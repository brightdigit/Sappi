//
//  PerfectSysInfo.swift
//  Perfect SysInfo
//
//  Created by Rockford Wei on May 3rd, 2017.
//	Copyright (C) 2017 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2017 - 2018 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//
#if os(Linux)
  import SwiftGlibc
#else
  import Darwin
#endif

class SysInfo {
  public static var Disk: [String: [String: UInt64]] {
    var stats: [String: [String: UInt64]] = [:]
    #if os(Linux)
      guard let content = "/proc/diskstats".asFile else { return stats }
      content.asLines.forEach { line in
        let tokens = line.asTokens()
        guard tokens.count > 13 else { return }
        /*
         0 - major number
         1 - minor mumber
         2 - device name
         3 - reads completed successfully
         4 - reads merged
         5 - sectors read
         6 - time spent reading (ms)
         7 - writes completed
         8 - writes merged
         9 - sectors written
         10 - time spent writing (ms)
         11 - I/Os currently in progress
         12 - time spent doing I/Os (ms)
         13 - weighted time spent doing I/Os (ms)
         */
        let title = tokens[2]
        var sta: [String: UInt64] = [:]
        let keys = ["major", "minor", "name",
                    "reads_completed", "reads_merged", "sectors_read",
                    "reading_ms", "writes_completed", "writes_merged",
                    "sectors_written", "writing_ms", "io_in_progress",
                    "io_ms", "weighte_io_ms"]
        for index in 3 ... 13 {
          sta[keys[index]] = UInt64(tokens[index]) ?? 0
        } // next i
        stats[title] = sta
      } // next
    #else
      do {
        stats = try DriverStats.devstats()
      } catch {
        // skipped the error
      }
    #endif
    return stats
  }

  #if os(Linux)
  #else
    internal static var interfaces: [String] {
      var ifaces = [String]()
      var mib = [CTL_NET, PF_ROUTE, 0, 0, NET_RT_IFLIST, 0]
      let NULL = UnsafeMutableRawPointer(bitPattern: 0)
      _ = mib.withUnsafeMutableBufferPointer { ptr -> Bool in

        guard let pmib = ptr.baseAddress else { return false }

        var len = 0
        guard sysctl(pmib, 6, NULL, &len, NULL, 0) == 0, len > 0
        else { return false }

        let buf = UnsafeMutablePointer<Int8>.allocate(capacity: len)
        if sysctl(pmib, 6, buf, &len, NULL, 0) == 0 {
          var cursor = 0
          repeat {
            cursor = buf.advanced(by: cursor).withMemoryRebound(to: if_msghdr.self, capacity: MemoryLayout<if_msghdr>.size) { pIfm -> Int in
              let ifm = pIfm.pointee
              if integer_t(ifm.ifm_type) == RTM_IFINFO {
                let interface = pIfm.advanced(by: 1).withMemoryRebound(to: Int8.self, capacity: 20) { sdl -> String in
                  let size = Int(sdl.advanced(by: 5).pointee)
                  let buf = sdl.advanced(by: 8)
                  buf.advanced(by: size).pointee = 0
                  let name = String(cString: buf)
                  return name
                } // end if
                if !interface.trimmed.isEmpty {
                  ifaces.append(interface)
                } // end if
              } // end if
              cursor += Int(ifm.ifm_msglen)
              return cursor
            } // end bound
          } while cursor < len
        } // end if
        buf.deallocate()
        return true
      } // end pointer
      return ifaces
    }
  #endif
  /// return total traffic summary from all interfaces,
  /// i for receiving and o for transmitting, both in KB
  public static var Net: [String: [String: Int]] {
    var netIO: [String: [String: Int]] = [:]
    #if os(Linux)
      guard let content = "/proc/net/dev".asFile else { return [:] }
      content.asLines.map { line -> (String, String) in
        guard let str = strdup(line) else { return ("", "") }
        if let column = strchr(str, 58) {
          let value = String(cString: column.advanced(by: 1))
          column.pointee = 0
          let key = String(cString: str)
          free(str)
          return (key, value)
        } else {
          free(str)
          return ("", "")
        }
      }.filter { !$0.0.isEmpty }.forEach { tag, line in
        guard let str = strdup(line) else { return }
        var numbers = [Int]()
        let delimiter = " \t\n\r"
        var token = strtok(str, delimiter)
        while let tok = token {
          numbers.append(Int(String(cString: tok)) ?? 0)
          token = strtok(nil, delimiter)
        } // end while
        free(str)
        if numbers.count < 9 { return }
        io[tag.trimmed] = ["rx": numbers[0] / 1_000_000, "tx": numbers[8] / 1_000_000]
      }
    #else
      let ifaces = interfaces
      var mib = [CTL_NET, PF_ROUTE, 0, 0, NET_RT_IFLIST2]
      let NULL = UnsafeMutableRawPointer(bitPattern: 0)
      guard (mib.withUnsafeMutableBufferPointer { ptr -> Bool in
        var len = 0
        guard sysctl(ptr.baseAddress, 6, NULL, &len, NULL, 0) == 0
        else { return false }

        let buf = UnsafeMutablePointer<Int8>.allocate(capacity: len)
        if sysctl(ptr.baseAddress, 6, buf, &len, NULL, 0) == 0 {
          var cursor = 0
          var index = 0
          repeat {
            cursor = buf.advanced(by: cursor).withMemoryRebound(to: if_msghdr.self, capacity: MemoryLayout<if_msghdr>.size) { pIfm -> Int in
              let ifm = pIfm.pointee
              cursor += Int(ifm.ifm_msglen)
              if integer_t(ifm.ifm_type) == RTM_IFINFO2 {
                pIfm.withMemoryRebound(to: if_msghdr2.self, capacity: MemoryLayout<if_msghdr2>.size) { _ in
                  let ifPd = pIfm.pointee
                  if index < ifaces.count {
                    netIO[ifaces[index]] = ["rx": Int(ifPd.ifm_data.ifi_ibytes) / 1_000_000, "tx": Int(ifPd.ifm_data.ifi_obytes) / 1_000_000]
                  } // end if
                  index += 1
                } // end ifm2
              } // end if
              return cursor
            } // end bound
          } while cursor < len
          buf.deallocate()
        } // end if
        return true
      }) else {
        return [:]
      } // end buf
    #endif
    return netIO
  }

  /// return physical CPU information
  public static var CPU: [String: [String: Int]] {
    #if os(Linux)
      let definition: [(keyName: String, isString: Bool)] = [
        ("name", true),
        ("user", false),
        ("nice", false),
        ("system", false),
        ("idle", false),
        ("iowait", false),
        ("irq", false),
        ("softirq", false),
        ("steal", false),
        ("guest", false),
        ("guest_nice", false)
      ]
      guard let content = "/proc/stat".asFile else { return [:] }
      let array = content.asLines.filter { $0.match(prefix: "cpu") }
        .map { $0.parse(definition: definition) }
      var lines: [String: [String: Int]] = [:]
      for item in array {
        guard let title = item["name"] else { continue }
        var stat: [String: Int] = [:]
        for (key, value) in (item.filter { $0.key != "name" }) {
          stat[key] = Int(value) ?? 0
        } // next
        lines[title] = stat
      } // next
    #else
      var pCPULoadArray = processor_info_array_t(bitPattern: 0)
      var processorMsgCount = mach_msg_type_name_t()
      var processorCount = natural_t()
      var totalUser = 0
      var totalIdle = 0
      var totalSystem = 0
      var totalNice = 0
      guard host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &processorCount, &pCPULoadArray, &processorMsgCount) == 0,
        let cpuLoadArray = pCPULoadArray
      else { return [:] }
      let cpuLoad = cpuLoadArray.withMemoryRebound(
        to: processor_cpu_load_info.self,
        capacity: Int(processorCount) * MemoryLayout<processor_cpu_load_info>.size
      ) { ptr -> processor_cpu_load_info_t in
        ptr
      }
      var lines: [String: [String: Int]] = [:]
      let count = Int(processorCount)
      for index in 0 ... count - 1 {
        // CPU_STATE_MAX = 4, CPU_STATE_IDLE = 2, CPU_STATE_NICE = 3,
        // CPU_STATE_USER = 0, CPU_STATE_SYSTEM = 1
        let user = Int(cpuLoad[index].cpu_ticks.0)
        let system = Int(cpuLoad[index].cpu_ticks.1)
        let idle = Int(cpuLoad[index].cpu_ticks.2)
        let nice = Int(cpuLoad[index].cpu_ticks.3)
        lines["cpu\(index)"] = ["user": user, "system": system, "idle": idle, "nice": nice]
        totalUser += user
        totalSystem += system
        totalIdle += idle
        totalNice += nice
      } // next
      munmap(cpuLoadArray, Int(vm_page_size))
      totalUser /= count
      totalSystem /= count
      totalIdle /= count
      totalNice /= count
      lines["cpu"] = ["user": totalUser, "system": totalSystem, "idle": totalIdle, "nice": totalNice]
    #endif
    return lines
  }

  /// return Metrics of Physical Memory, each counter in Megabytes
  public static var Memory: [String: Int] {
    #if os(Linux)
      guard let content = "/proc/meminfo".asFile else { return [:] }
      var stat: [String: Int] = [:]
      content.split(separator: Character("\n")).forEach { line in
        let lines: [String] = line.split(separator: Character(":")).map(String.init)
        let key = lines[0]
        guard lines.count > 1, let str = strdup(lines[1]) else { return }
        if let kBStr = strstr(str, "kB") {
          kBStr.pointee = 0
        } // end if
        let value = String(cString: str).trimmed
        stat[key] = (Int(value) ?? 0) / 1024
        free(str)
      }
      return stat
    #else
      let size = MemoryLayout<vm_statistics>.size / MemoryLayout<integer_t>.size
      let pStat = UnsafeMutablePointer<integer_t>.allocate(capacity: size)
      var stat: [String: Int] = [:]
      var count = mach_msg_type_number_t(size)
      if host_statistics(mach_host_self(), HOST_VM_INFO, pStat, &count) == 0 {
        let array = Array(UnsafeBufferPointer(start: pStat, count: size))
        let tags = ["free", "active", "inactive", "wired", "zero_filled", "reactivations", "pageins", "pageouts", "faults", "cow", "lookups", "hits"]
        let cnt = min(tags.count, array.count)
        for index in 0 ... cnt - 1 {
          let key = tags[index]
          let value = array[index]
          stat[key] = Int(value) / 256
        } // next i
      } // end if
      pStat.deallocate()
      return stat
    #endif
  } // end var
}

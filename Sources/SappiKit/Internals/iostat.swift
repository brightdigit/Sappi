#if os(Linux)
#else
  import Darwin
  import Foundation
  import IOKit

  struct DriverStats {
    public var driver = io_registry_entry_t()
    public var name = ""
    public var blocksize = UInt64(0)
    public var totalBytes = UInt64(0)
    public var totalTransfers = UInt64(0)
    public var totalTime = UInt64(0)

    static func record_device(_ drive: io_registry_entry_t) throws -> DriverStats {
      var parent = io_registry_entry_t()
      guard KERN_SUCCESS == IORegistryEntryGetParentEntry(drive, kIOServicePlane, &parent) else {
        throw Panic.deviceHasNoParent
      } // end guard
      guard IOObjectConformsTo(parent, "IOBlockStorageDriver") != 0 else {
        IOObjectRelease(parent)
        throw Panic.deviceDoesNotConformToStorageDriver
      } // end if
      var drv = DriverStats()
      drv.driver = parent
      var properties: Unmanaged<CFMutableDictionary>?
      guard
        KERN_SUCCESS == IORegistryEntryCreateCFProperties(drive, &properties, kCFAllocatorDefault, 0),
        let prop = properties?.takeUnretainedValue() as? [String: Any],
        let name = prop[kIOBSDNameKey] as? String
      else {
        throw Panic.deivceHasNoProperties
      }
      properties?.release()
      drv.name = name
      drv.blocksize = prop["Preferred Block Size"] as? UInt64 ?? 0
      return drv
    }

    static func record_all_devices(maxshowdevs: Int = 5) throws -> [DriverStats] {
      var drivestat = [DriverStats]()
      guard
        let ioMedia = IOServiceMatching("IOMedia"),
        let iomatch = ioMedia as? [String: Any]
      else {
        throw Panic.matchIOMediaFailed
      }

      var match = iomatch
      match["Whole"] = kCFBooleanTrue

      var drivelist = io_iterator_t()

      guard
        KERN_SUCCESS == IOServiceGetMatchingServices(kIOMasterPortDefault, match as CFDictionary, &drivelist)
      else {
        throw Panic.matchIOMediaFailed
      } // end guard
      var drive = io_object_t(0)
      for _ in 0 ... maxshowdevs {
        drive = IOIteratorNext(drivelist)
        if drive == io_object_t(0) {
        } else {
          do {
            let driverStats = try record_device(drive)
            drivestat.append(driverStats)
          } catch {} // ignore
        }
        IOObjectRelease(drive)
      } // next
      IOObjectRelease(drivelist)
      return drivestat
    }

    internal static func devstats() throws -> [String: [String: UInt64]] {
      let drives = try record_all_devices()
      var reports: [String: [String: UInt64]] = [:]
      for drv in drives {
        var properties: Unmanaged<CFMutableDictionary>?
        guard
          KERN_SUCCESS == IORegistryEntryCreateCFProperties(drv.driver, &properties, kCFAllocatorDefault, 0),
          let prop = properties?.takeUnretainedValue() as? [String: Any],
          let stat = prop["Statistics"] as? [String: Any]
        else {
          break
        } // end guard
        properties?.release()
        var report: [String: UInt64] = [:]
        report["bytes_read"] = stat["Bytes (Read)"] as? UInt64 ?? 0
        report["bytes_written"] = stat["Bytes (Write)"] as? UInt64 ?? 0
        report["operations_read"] = stat["Operations (Read)"] as? UInt64 ?? 0
        report["operations_written"] = stat["Operations (Write)"] as? UInt64 ?? 0
        report["latency_time_read"] = stat["Latency Time (Read)"] as? UInt64 ?? 0
        report["latency_time_written"] = stat["Latency Time (Write)"] as? UInt64 ?? 0
        reports[drv.name] = report
      }
      return reports
    }
  }

#endif

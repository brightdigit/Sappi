import Foundation
import ArgumentParser
import PerfectSysInfo
import NetUtils

struct Memory {
  let free : Int
  let total : Int
}
struct Volume {
  let name : String
  let available: Int
  let total: Int
}

struct Temperature {
  let value : Int
  let key : String
}

struct CPUData {
  let temperature : Temperature
  let idle : Int
  let sum : Int
}
struct CPU {
  let cores : [CPUData]
  let cpu : CPUData
}

struct SystemInfo {
  let cpu : CPU
  let volumes: [Volume]
  let memory : Memory
  let processes : Int
}
/**
 System load:            0.0
 Usage of /:             5.5% of 116.92GB
 Memory usage:           28%
 Swap usage:             0%
 Temperature:            49.9 C
 Processes:              149
 Users logged in:        1
 IPv4 address for eth0:  192.168.1.109
 IPv6 address for eth0:  2600:1702:4050:7d30::505
 IPv6 address for eth0:  2600:1702:4050:7d30:ba27:ebff:fef4:1c1e
 IPv4 address for wlan0: 192.168.1.120
 IPv6 address for wlan0: 2600:1702:4050:7d30::3f1
 IPv6 address for wlan0: 2600:1702:4050:7d30:ba27:ebff:fea1:494b
 */

public func parseTempKey(_ key : String) -> Int? {
  guard let numChar = key.first(where: { $0.isNumber }) else {
    return nil
  }
  
  guard let num = Int(String(numChar)) else {
    return nil
  }
  
  let parts = key.split(separator: numChar)
  guard parts.count == 2 else {
    return nil
  }
  
  //print(parts)
  
  guard parts.first == "TC", parts.last?.uppercased() == "C" else {
    return nil
  }
  
  return num
}


extension Array {
  func firstMap<Value> (_ closure: (Element) -> Value?) -> Value? {
    for element in self {
      if let value = closure(element) {
        return value
      }
    }
    return nil
  }
}

var temperatures = [Temperature]()
let dieTemp : Temperature?
#if canImport(IOKit) && false
let smc = SMCService()
let indicies = smc.getAllKeys().compactMap(parseTempKey(_:))

let dieTemp = ["TC0C", "TC0D", "TC0P", "TC0E"].firstMap(smc.getValue(_:)).map { (value) -> Temperature in
  Temperature(value: Int(value), key: "TC0D")
}
guard indicies.count - 1 == indicies.max() else {
  fatalError()
}
let max = indicies.max() ?? 0
for index in 0...max {
  let key = "TC\(index)C"
  if let value = smc.getValue(key) {
    temperatures.append(Temperature(value: Int(value), key: key))
  }
}
// https://superuser.com/questions/553197/interpreting-sensor-names
#else

let baseURL = URL(fileURLWithPath: "/sys/class/thermal/")
var cpuTemps = [String: Int]()
repeat {
  let dirURL = baseURL.appendingPathComponent("thermal_zone\(cpuTemps.count)")
let type : String
  let tempStr  : String
  do {
    type = try String(contentsOf: dirURL.appendingPathComponent("type"))
    tempStr = try String(contentsOf: dirURL.appendingPathComponent("temp"))
  } catch {
//print(error)
    break
  }

  guard let temp = Int(tempStr.trimmingCharacters(in: .whitespacesAndNewlines)) else {
    break
  }
  temperatures.append(Temperature(value: temp / 1000, key: type.trimmingCharacters(in: .whitespacesAndNewlines)))
} while true
// /sys/class/thermal/thermal_zone*/temp (millidegrees C)
#endif


let mainCpu : CPUData
let cores : [CPUData]
let cpuValue : Double?
let sysCPU  = SysInfo.CPU
guard let cpuS = sysCPU["cpu"], let die = dieTemp else {
  fatalError()
}
  let cpuSum = cpuS.map{$0.value}.reduce(0, +)
  let cpuIdle = cpuS["idle"] ?? 0
  mainCpu = CPUData(temperature: die, idle: cpuIdle, sum: cpuSum)

cores = temperatures.enumerated().compactMap { (index, temp) -> CPUData? in
  guard let core = sysCPU["cpu\(index)"] else {
    return nil
  }
  let cpuSum = core.map{$0.value}.reduce(0, +)
  let cpuIdle = core["idle"] ?? 0
  return CPUData(temperature: temp, idle: cpuIdle, sum: cpuSum)
}

let cpu = CPU(cores: cores, cpu: mainCpu)
var volumedict = [String : Volume]()
//print(SysInfo.Disk)
let volumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey], options: [])!


for volume in volumeURLs {
  guard let resourceValues = try? volume.resourceValues(forKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey]) else {
    continue
  }
  
  let name = resourceValues.volumeName ?? volume.path
  
  guard let total = resourceValues.volumeTotalCapacity,
        let available = resourceValues.volumeAvailableCapacity else {
    continue
  }
  
  guard !volumedict.keys.contains(name) else {
    continue
  }
  
  volumedict[name] = Volume(name: name, available: available, total: total)
  
}

let memory = SysInfo.Memory
let total : Int
let free : Int
if let memtotal = memory["MemTotal"], let memfree = memory["MemAvailable"] {
  total = memtotal
  free = memfree
} else {
  
  let totalKeys = ["free", "active", "inactive", "wired"]

  total = memory.filter{totalKeys.contains($0.key)}.map{ $0.value }.reduce(0, +)
  free = memory["free"] ?? 0
}

print("Memory usage:", 100 - (free*100/total) )

let processesCount : Int
#if canImport(Darwin)
var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0]
var size = 0
let ret = sysctl(&mib, 4, nil, &size, nil, 0)
processesCount = size/MemoryLayout<kinfo_proc>.size
#else
let contents = try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/proc"), includingPropertiesForKeys: nil, options: [])
var count = 0
for dir : URL in contents {
  if FileManager.default.fileExists(atPath: dir.appendingPathComponent("task").path) {
    count += 1
  }
  
}
processesCount = count
#endif

let info = SystemInfo(cpu: cpu, volumes: Array(volumedict.values), memory: Memory(free: free, total: total), processes: processesCount)

print(info)

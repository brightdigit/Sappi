import Foundation
import ArgumentParser
import PerfectSysInfo
import NetUtils

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

enum OS {
  case macOS
  case linux
}

struct TemperatureCollection {
  let os : OS
  let temperatures : [String : Double]
}
let temperatures : [String : Double]
#if canImport(IOKit)
let smc = SMCService()
let keys = smc.getAllKeys()
temperatures = Dictionary.init(uniqueKeysWithValues: keys.map{
  ($0, smc.getValue($0))
}).compactMapValues{ $0 }
//for key in keys {
//  if let value = smc.getValue(key) {
//    print(key, value)
//  }
//}
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
  cpuTemps[type.trimmingCharacters(in: .whitespacesAndNewlines)] = temp
} while true
temperatures = cpuTemps.mapValues{ Double($0) / 1000.0}
// /sys/class/thermal/thermal_zone*/temp (millidegrees C)
#endif

let cpuValue : Double?
if let cpu = SysInfo.CPU["cpu"] {
  let cpuSum = cpu.map{$0.value}.reduce(0, +)
  let cpuIdle = cpu["idle"] ?? 0
  cpuValue = 1.0 - Double(cpuIdle)/Double(cpuSum)
} else {
  cpuValue = nil
}

if let cpuPercent = cpuValue.map({ $0 * 100.0}) {
  print("CPU Usage:", cpuPercent)
}

//print(SysInfo.Disk)
let url = URL(fileURLWithPath: "/Volumes")
let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey], options: [])!

for volume in volumes {
  guard let resourceValues = try? volume.resourceValues(forKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey]) else {
    continue
  }
  let usage = Double(resourceValues.volumeAvailableCapacity ?? 0 )/Double(resourceValues.volumeTotalCapacity ?? 0)
  
  let name =  resourceValues.volumeName ?? volume.path
  print("Usage of \(name):", usage * 100.0)
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

#if canImport(Darwin)
var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0]
var size = 0
let ret = sysctl(&mib, 4, nil, &size, nil, 0)
print("processes:", size/MemoryLayout<kinfo_proc>.size)
#else
let contents = try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: "/proc"), includingPropertiesForKeys: nil, options: [])
var count = 0
for dir : URL in contents {
  if FileManager.default.fileExists(atPath: dir.appendingPathComponent("task").path) {
    count += 1
  }
  
}
print("processes:", count)
#endif


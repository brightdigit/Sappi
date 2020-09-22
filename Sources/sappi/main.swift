import Foundation
import ArgumentParser
import PerfectSysInfo
import NetUtils
import IOKit
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

//print(SysInfo.CPU)

let cpuValue : Double?
if let cpu = SysInfo.CPU["cpu"] {
  let cpuSum = cpu.map{$0.value}.reduce(0, +)
  let cpuIdle = cpu["idle"] ?? 0
  cpuValue = 1.0 - Double(cpuIdle)/Double(cpuSum)
} else {
  cpuValue = nil
}

print("CPU Usage:", cpuValue.map{ $0 * 100.0})
//print(SysInfo.Memory)

print(SysInfo.Disk)
let url = URL(fileURLWithPath: "/Volumes")
let volumes = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey], options: [])

for volume in volumes {
  guard let resourceValues = try? volume.resourceValues(forKeys: [.volumeURLKey, .volumeNameKey, .volumeAvailableCapacityKey, .volumeTotalCapacityKey]) else {
    continue
  }
  let usage = Double(resourceValues.volumeAvailableCapacity ?? 0 )/Double(resourceValues.volumeTotalCapacity ?? 0)
  
  let name =  resourceValues.volumeName ?? volume.path
  print("Usage of \(name):", usage * 100.0)
}

//URL.resourceValues(forKeys: [.volumeAvailableCapacityKey, ], fromBookmarkData: <#T##Data#>)

//print(SysInfo.Net)
//print(Interface.allInterfaces())



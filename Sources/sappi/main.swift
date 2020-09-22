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

print(cpuValue)
//print(SysInfo.Memory)
//print(SysInfo.Disk)
//print(SysInfo.Net)
//print(Interface.allInterfaces())



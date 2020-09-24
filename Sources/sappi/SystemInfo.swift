
struct SystemInfo {
  let cpu : CPU
  let volumes: [Volume]
  let memory : Memory
  let networks : [Network]
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


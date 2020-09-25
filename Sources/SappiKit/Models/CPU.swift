public struct CPU : Codable {
  public let cores: [CPUData]
  public let cpu: CPUData
  public let temperatures: [Temperature]
}

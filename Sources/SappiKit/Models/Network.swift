public struct Network {
  public let address: String
  public let family: InterfaceFamily
  public let name: String

  init?(interface: Interface) {
    guard interface.isUp, interface.isRunning, !interface.isLoopback else {
      return nil
    }
    guard let address = interface.address ?? interface.broadcastAddress else {
      return nil
    }

    let family = interface.family
    let name = interface.name
    self.name = name
    self.family = family
    self.address = address
  }
}

public enum InterfaceFamily: Int, CustomStringConvertible {
  /// IPv4.
  case ipv4

  /// IPv6.
  case ipv6

  /// Used in case of errors.
  case other

  /// String representation of the address family.
  public var description: String {
    switch self {
    case .ipv4: return "IPv4"
    case .ipv6: return "IPv6"
    default: return "other"
    }
  }
}

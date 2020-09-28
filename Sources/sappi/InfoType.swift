import ArgumentParser

/**
 Various Metrics, you can request.
 */
public enum InfoType: String, ExpressibleByArgument, CaseIterable, Comparable {
  /**
   CPU and Core Usage. Includes temperature information in verbose mode.
   */
  case cpu
  /**
   Memory Usage.
   */
  case memory
  /**
   Disk Volume Usage.
   */
  case disks
  /**
   Number of Active Processes.
   */
  case processes
  /**
    Each connected network and address.
   */
  case network

  /**
    Sorted value.
   */
  var value: Int {
    switch self {
    case .cpu:
      return 0
    case .memory:
      return 1
    case .disks:
      return 2
    case .processes:
      return 3
    case .network:
      return 4
    }
  }

  public static func < (lhs: InfoType, rhs: InfoType) -> Bool {
    lhs.value < rhs.value
  }
}

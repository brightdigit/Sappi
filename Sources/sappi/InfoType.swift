import ArgumentParser

enum InfoType: String, ExpressibleByArgument, CaseIterable, Comparable {
  case cpu
  case memory
  case disks
  case processes
  case network

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

  static func < (lhs: InfoType, rhs: InfoType) -> Bool {
    lhs.value < rhs.value
  }
}

import SappiKit

public protocol Rational {
  var denominator: Int { get }
  var numerator: Int { get }
  var shouldUseInverse: Bool { get }
  var label: String { get }
  var defaultFormat: RatioFormat { get }
}

extension Rational {
  var labelledSum: String {
    if let units = self as? SummableUnits {
      return units.labelledSum
    } else {
      return "\(denominator)"
    }
  }
}

extension Rational {
  var percent: Percent {
    return Percent(numerator, denominator, inverse: shouldUseInverse)
  }

  var ratio: String {
    return "\(numerator) \(label), \(denominator) total"
  }
}

extension Rational {
  func formattedAs(_ format: RatioFormat) -> String {
    switch format {
    case .percent:
      return "\(percent)"
    case .ratio:
      return ratio
    case .default:
      let format = defaultFormat == .default ? .percent : defaultFormat
      return formattedAs(format)
    case .percentTotal:
      return "\(percent) of \(labelledSum)"
    }
  }
}

extension CPUData: Rational {
  public var denominator: Int {
    return sum
  }

  public var numerator: Int {
    return idle
  }

  public var shouldUseInverse: Bool {
    return true
  }

  public var label: String {
    return "idle"
  }

  public var defaultFormat: RatioFormat {
    return .percent
  }
}

extension Memory: Rational {
  public var denominator: Int {
    return total
  }

  public var numerator: Int {
    return free
  }

  public var shouldUseInverse: Bool {
    return true
  }

  public var label: String {
    return "free"
  }

  public var defaultFormat: RatioFormat {
    return .percent
  }
}

extension Volume: SummableUnits {
  public static var units: String {
    return "GB"
  }

  public static var factor: Int {
    return 1_000_000_000
  }

  public static var precision: Int {
    return 2
  }

  public var denominator: Int {
    return total
  }

  public var numerator: Int {
    return available
  }

  public var shouldUseInverse: Bool {
    return true
  }

  public var label: String {
    return "available"
  }

  public var defaultFormat: RatioFormat {
    return .percentTotal
  }
}

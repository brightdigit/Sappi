import SappiKit

protocol Rational {
  var denominator: Int { get }
  var numerator: Int { get }
  var shouldUseInverse: Bool { get }
  var label: String { get }
  var defaultFormat: RatioFormat { get }
}

extension Rational {
  var labelledSum: String {
    if let su = self as? SummableUnits {
      return su.labelledSum
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
  var denominator: Int {
    return sum
  }

  var numerator: Int {
    return idle
  }

  var shouldUseInverse: Bool {
    return true
  }

  var label: String {
    return "idle"
  }

  var defaultFormat: RatioFormat {
    return .percent
  }
}

extension Memory: Rational {
  var denominator: Int {
    return total
  }

  var numerator: Int {
    return free
  }

  var shouldUseInverse: Bool {
    return true
  }

  var label: String {
    return "free"
  }

  var defaultFormat: RatioFormat {
    return .percent
  }
}

extension Volume: SummableUnits {
  static var units: String {
    return "GB"
  }

  static var factor: Int {
    return 1_000_000_000
  }

  static var precision: Int {
    return 2
  }

  var denominator: Int {
    return total
  }

  var numerator: Int {
    return available
  }

  var shouldUseInverse: Bool {
    return true
  }

  var label: String {
    return "available"
  }

  var defaultFormat: RatioFormat {
    return .percentTotal
  }
}

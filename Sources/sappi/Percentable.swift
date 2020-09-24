import SappiKit

protocol Percentable {
  var denominator: Int { get }
  var numerator: Int { get }
  var shouldUseInverse: Bool { get }
}

extension Percentable {
  var percent: Percent {
    return Percent(numerator, denominator, inverse: shouldUseInverse)
  }
}

extension CPUData: Percentable {
  var denominator: Int {
    return sum
  }

  var numerator: Int {
    return idle
  }

  var shouldUseInverse: Bool {
    return true
  }
}

extension Memory: Percentable {
  var denominator: Int {
    return total
  }

  var numerator: Int {
    return free
  }

  var shouldUseInverse: Bool {
    return true
  }
}

extension Volume: Percentable {
  var denominator: Int {
    return total
  }

  var numerator: Int {
    return available
  }

  var shouldUseInverse: Bool {
    return true
  }
}

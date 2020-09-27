protocol SummableUnits: Rational {
  static var units: String { get }
  static var factor: Int { get }
  static var precision: Int { get }
}

extension SummableUnits {
  var labelledSum: String {
    let precisionFactor = repeatElement(10, count: Self.precision).reduce(1, *)
    let factorFactor = Self.factor / precisionFactor
    return "\(Double(denominator / factorFactor) / Double(precisionFactor))\(Self.units)"
  }
}

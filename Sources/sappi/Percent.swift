public struct Percent: CustomStringConvertible {
  let denominator: Int
  let numerator: Int

  public init(_ numerator: Int, _ denominator: Int, inverse: Bool = false) {
    self.numerator = inverse ? denominator - numerator : numerator
    self.denominator = denominator
  }

  public var integerValue: Int {
    return numerator * 100 / denominator
  }

  public var description: String {
    return "\(integerValue)%"
  }
}

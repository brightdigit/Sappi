import SappiKit

public extension Temperature {
  func value(inUnits unit: TemperatureUnit) -> Double {
    let doubleValue = Double(value)
    let scale = type(of: unit.scale)
    return doubleValue * scale.factor + scale.offset
  }

  func formatted(inUnits unit: TemperatureUnit) -> String {
    let suffix = type(of: unit.scale).suffix
    return "\(value(inUnits: unit))\(suffix)"
  }
}

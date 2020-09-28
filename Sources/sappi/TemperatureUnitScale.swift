public protocol TemperatureUnitScale {
  static var factor: Double { get }
  static var offset: Double { get }
  static var suffix: String { get }
}

// swiftlint:disable nesting
public extension TemperatureUnit {
  struct Scales {
    static let celsuis = Celsuis.scale
    static let fahrenheit = Fahrenheit.scale
    static let rankine = Rankine.scale
    static let delisle = Delisle.scale
    static let newton = Newton.scale
    static let réaumur = Réaumur.scale
    static let rømer = Rømer.scale

    struct Celsuis: TemperatureUnitScale {
      static let factor: Double = 1

      static let offset: Double = 0
      static let suffix: String = "°C"
      private init() {}
      static let scale = Celsuis()
    }

    struct Fahrenheit: TemperatureUnitScale {
      static let factor: Double = (9.0 / 5.0)

      static let offset: Double = 32
      static let suffix: String = "°F"

      private init() {}
      static let scale = Fahrenheit()
    }

    struct Kelvin: TemperatureUnitScale {
      static let factor: Double = 1.0

      static let offset: Double = 273.15
      static let suffix: String = "°K"

      private init() {}
      static let scale = Kelvin()
    }

    struct Rankine: TemperatureUnitScale {
      static let factor: Double = Fahrenheit.factor

      static let offset: Double = Fahrenheit.factor * Kelvin.offset

      static let suffix: String = "°R"
      private init() {}
      static let scale = Rankine()
    }

    struct Delisle: TemperatureUnitScale {
      static let factor: Double = (-3.0 / 2.0)
      static let offset: Double = Self.factor * 100.0
      static let suffix: String = "°D"
      private init() {}
      static let scale = Delisle()
    }

    struct Newton: TemperatureUnitScale {
      static let factor: Double = (33.0 / 100.0)

      static let offset: Double = 0.0
      static let suffix: String = "°N"
      private init() {}
      static let scale = Newton()
    }

    struct Réaumur: TemperatureUnitScale {
      static let factor: Double = (4.0 / 5.0)

      static let offset: Double = 0
      static let suffix: String = "°Ré"
      private init() {}
      static let scale = Réaumur()
    }

    struct Rømer: TemperatureUnitScale {
      static var factor: Double = 21.0 / 70.0

      static var offset: Double = 7.5
      static let suffix: String = "°Rø"
      private init() {}
      static let scale = Rømer()
    }
  }

  var scale: TemperatureUnitScale {
    switch self {
    case .celsuis:
      return Scales.celsuis
    case .fahrenheit:
      return Scales.fahrenheit
    case .rankine:
      return Scales.rankine
    case .delisle:
      return Scales.delisle
    case .newton:
      return Scales.newton
    case .réaumur:
      return Scales.réaumur
    case .rømer:
      return Scales.rømer
    }
  }
}

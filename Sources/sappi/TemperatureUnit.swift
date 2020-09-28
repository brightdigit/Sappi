import ArgumentParser
import SappiKit
/**
 Temperature Scales for Formatting.
 */
public enum TemperatureUnit: String, ExpressibleByArgument {
  /// Celsuis Scale
  case celsuis
  /// Fahrenheit Scale
  case fahrenheit
  /// Rankine Scale
  case rankine
  /// Delisle Scale
  case delisle
  /// Newton Scale
  case newton
  /// Réaumur Scale
  case réaumur
  /// Rømer Scale
  case rømer
}

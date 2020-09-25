import ArgumentParser

struct SappiOptions: ParsableArguments {
  @Argument(help: "Set of system information data, you'd like to receive.")
  var infoTypes = InfoType.allCases

  @Option(help: "Format of value types")
  var valueFormat: RatioFormat = .default

  @Flag(help: "Output all values available.")
  var verbose: Bool = false

  @Option(help: "Unit of Temperature")
  var temperatureUnit = TemperatureUnit.celsuis
}

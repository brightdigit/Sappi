import ArgumentParser

public struct SappiOptions: ParsableArguments {
  @Argument(help: "Set of system information data, you'd like to receive.")
  public var infoTypes = InfoType.allCases

  @Option(help: "Format of value types")
  public var valueFormat: RatioFormat = .default

  @Flag(help: "Output all values available.")
  public var verbose: Bool = false

  @Option(help: "Unit of Temperature")
  public var temperatureUnit = TemperatureUnit.celsuis

  public init() {}
}

import ArgumentParser

struct SappiOptions: ParsableArguments {
  @Argument
  var infoTypes = InfoType.allCases

  @Option
  var valueFormat: RatioFormat = .default

  @Flag
  var verbose: Bool = false
}

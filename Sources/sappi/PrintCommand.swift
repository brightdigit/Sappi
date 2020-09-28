import ArgumentParser
import SappiKit

public extension SappiCommand {
  struct PrintCommand: ParsableCommand {
    public static var configuration = CommandConfiguration(commandName: "print",
                                                           abstract: "Prints system information out to the console.")

    @OptionGroup
    var options: SappiOptions

    public func run() throws {
      let textFormatter = TextFormatter()
      textFormatter.format(SystemInfo(), withOptions: options, to: &FileHandleStream.standardOutput)
    }

    public init() {}
  }
}

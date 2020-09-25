import ArgumentParser
import SappiKit

extension SappiCommand {
  struct PrintCommand: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "print")

    @OptionGroup
    var options: SappiOptions

    func run() throws {
      let textFormatter = TextFormatter()
      textFormatter.format(SystemInfo(), withOptions: options, to: &FileHandleStream.standardOutput)
    }
  }
}

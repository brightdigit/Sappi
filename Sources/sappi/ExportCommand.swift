import ArgumentParser
import SappiKit

extension SappiCommand {
  struct ExportCommand: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "export")

    @Option
    var format: ExportFormat = .text

    @OptionGroup
    var options: SappiOptions

    func run() throws {
      var output = FileHandleStream.standardOutput
      try format.formatter.format(SystemInfo(), withOptions: options, to: &output)
    }
  }
}

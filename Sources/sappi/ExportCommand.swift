import ArgumentParser
import SappiKit

public extension SappiCommand {
  struct ExportCommand: ParsableCommand {
    public static var configuration = CommandConfiguration(
      commandName: "export",
      abstract: "Exports system information in any format."
    )

    @Option(help: "Export format.")
    var format: ExportFormat = .text

    @OptionGroup
    var options: SappiOptions

    public func run() throws {
      var output = FileHandleStream.standardOutput
      try format.formatter.format(SystemInfo(), withOptions: options, to: &output)
    }

    public init() {}
  }
}

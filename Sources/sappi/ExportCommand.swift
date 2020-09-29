import ArgumentParser
import Foundation
import SappiKit

public extension SappiCommand {
  struct ExportCommand: ParsableCommand {
    public static var configuration = CommandConfiguration(
      commandName: "export",
      abstract: "Exports system information in any format."
    )

    @Argument
    var file: String?

    @Option(help: "Export format.")
    var format: ExportFormat = .text

    @OptionGroup
    var options: SappiOptions

    public func run() throws {
      var output: AnyStream
      if let file = file {
        guard FileManager.default.createFile(atPath: file, contents: nil, attributes: nil) else {
          throw ExitCode.failure
        }
        guard let handle = FileHandle(forWritingAtPath: file) else {
          throw ExitCode.failure
        }
        output = AnyStream(FileHandleStream(handle))
      } else {
        output = AnyStream(FileHandleStream.standardOutput)
      }
      try format.formatter.format(SystemInfo(), withOptions: options, to: &output)
    }

    public init() {}
  }
}

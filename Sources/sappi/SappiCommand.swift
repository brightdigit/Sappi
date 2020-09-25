import ArgumentParser
import SappiKit

struct SappiCommand: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "sappi",
    abstract: "Prints and exports system information.",
    subcommands: [PrintCommand.self, ExportCommand.self],
    defaultSubcommand: PrintCommand.self
  )
}

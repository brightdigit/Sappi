import ArgumentParser
import SappiKit

struct SappiCommand: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "sappi",
    subcommands: [PrintCommand.self],
    defaultSubcommand: PrintCommand.self
  )
}

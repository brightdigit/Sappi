import ArgumentParser
import SappiKit

public struct SappiCommand: ParsableCommand {
  public static var configuration = CommandConfiguration(
    commandName: "sappi",
    abstract: "Prints and exports system information.",
    subcommands: [PrintCommand.self, ExportCommand.self],
    defaultSubcommand: PrintCommand.self
  )

  public init() {}
}

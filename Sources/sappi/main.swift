import ArgumentParser
import Foundation
import SappiKit

struct SappiCommand: ParsableCommand {
  func run() throws {
    print(SystemInfo.fetch())
  }
}

SappiCommand.main()

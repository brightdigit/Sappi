import ArgumentParser
import SappiKit

struct SappiCommand: ParsableCommand {
  @Argument
  var infoTypes = InfoType.allCases

  @Option
  var format: RatioFormat = .default

  func run() throws {
    let typeSet = Set(infoTypes).sorted()
    let systemInfo = SystemInfo.fetch()
    for type in typeSet {
      switch type {
      case .cpu:
        print("CPU Usage:", systemInfo.cpu.cpu.formattedAs(format))
      case .memory:
        print("Memory Usage:", systemInfo.memory.formattedAs(format))
      case .disks:
        for volume in systemInfo.volumes {
          // print("Usage of \(volume.name):", "\(volume.percent) of \(Double(volume.total / 10_000_000) / 100)GB")
          print("Usage of \(volume.name):", volume.formattedAs(format))
        }
      case .processes:
        print("Processes:", systemInfo.processes)
      case .network:
        for interface in systemInfo.networks {
          print("\(interface.family) address for \(interface.name): \(interface.address)")
        }
      }
    }
  }
}

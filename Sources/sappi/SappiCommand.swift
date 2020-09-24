import ArgumentParser
import SappiKit

struct SappiCommand: ParsableCommand {
  @Argument
  var infoTypes = InfoType.allCases

  func run() throws {
    let typeSet = Set(infoTypes).sorted()
    let systemInfo = SystemInfo.fetch()
    for type in typeSet {
      switch type {
      case .cpu:
        print("CPU Usage:", systemInfo.cpu.cpu.percent)
      case .memory:
        print("Memory Usage:", systemInfo.memory.percent)
      case .disks:
        for volume in systemInfo.volumes {
          print("Usage of \(volume.name):", "\(volume.percent)% of \(Double(volume.total / 10_000_000) / 100)GB")
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

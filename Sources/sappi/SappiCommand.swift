import ArgumentParser
import SappiKit

struct SappiCommand: ParsableCommand {
  @Argument
  var infoTypes = InfoType.allCases

  @Option
  var format: RatioFormat = .default

  @Flag
  var verbose: Bool = false

  func run() throws {
    let typeSet = Set(infoTypes).sorted()
    let systemInfo = SystemInfo()
    for type in typeSet {
      switch type {
      case .cpu:
        print("CPU Usage:", systemInfo.cpu.cpu.formattedAs(format))
        if verbose {
          for (index, core) in systemInfo.cpu.cores.enumerated() {
            print("CPU \(index + 1) Usage:", core.formattedAs(format))
          }
          for (index, temp) in systemInfo.cpu.temperatures.enumerated() {
            if index == 0 {
              print("CPU Die Temperature:", "\(temp.value)°C")
            } else {
              print("Core \(index) Temperature:", "\(temp.value)°C")
            }
          }
        }
      case .memory:
        print("Memory Usage:", systemInfo.memory.formattedAs(format))
      case .disks:
        for volume in systemInfo.volumes {
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

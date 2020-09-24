import ArgumentParser
import SappiKit

extension SappiCommand {
  struct PrintCommand: ParsableCommand {
    static var configuration = CommandConfiguration(commandName: "print")

    @OptionGroup
    var options: SappiOptions

    func run() throws {
      let typeSet = Set(options.infoTypes).sorted()
      let systemInfo = SystemInfo()
      for type in typeSet {
        switch type {
        case .cpu:
          print("CPU Usage:", systemInfo.cpu.cpu.formattedAs(options.valueFormat))
          if options.verbose {
            for (index, core) in systemInfo.cpu.cores.enumerated() {
              print("CPU \(index + 1) Usage:", core.formattedAs(options.valueFormat))
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
          print("Memory Usage:", systemInfo.memory.formattedAs(options.valueFormat))
        case .disks:
          for volume in systemInfo.volumes {
            print("Usage of \(volume.name):", volume.formattedAs(options.valueFormat))
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
}

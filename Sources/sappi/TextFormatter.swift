import SappiKit

struct TextFormatter: Formatter {
  func format<Target>(_ systemInfo: SystemInfo, withOptions options: SappiOptions, to target: inout Target) where Target: TextOutputStream {
    let typeSet = Set(options.infoTypes).sorted()
    let systemInfo = SystemInfo()
    for type in typeSet {
      switch type {
      case .cpu:
        print("CPU Usage:", systemInfo.cpu.cpu.formattedAs(options.valueFormat), to: &target)
        if options.verbose {
          for (index, core) in systemInfo.cpu.cores.enumerated() {
            print("CPU \(index + 1) Usage:", core.formattedAs(options.valueFormat), to: &target)
          }
          for (index, temp) in systemInfo.cpu.temperatures.enumerated() {
            if index == 0 {
              print("CPU Die Temperature:", "\(temp.value)°C", to: &target)
            } else {
              print("Core \(index) Temperature:", "\(temp.value)°C", to: &target)
            }
          }
        }
      case .memory:
        print("Memory Usage:", systemInfo.memory.formattedAs(options.valueFormat), to: &target)
      case .disks:
        for volume in systemInfo.volumes {
          print("Usage of \(volume.name):", volume.formattedAs(options.valueFormat), to: &target)
        }
      case .processes:
        print("Processes:", systemInfo.processes, to: &target)
      case .network:
        for interface in systemInfo.networks {
          print("\(interface.family) address for \(interface.name): \(interface.address)", to: &target)
        }
      }
    }
  }
}

import Foundation
import SappiKit

struct CSVFormatter: Formatter {
  struct Entry {
    let category: String
    let label: String
    let value: String?
    let total: String

    var description: String {
      [category, label, value ?? "", total].joined(separator: ",")
    }
  }

  func format<Target>(_ systemInfo: SystemInfo, withOptions options: SappiOptions, to target: inout Target) throws where Target: TextOutputStream, Target: BinaryOutputStream {
    let typeSet = Set(options.infoTypes).sorted()
    let systemInfo = SystemInfo()
    var entries = [Entry]()
    for contentType in typeSet {
      switch contentType {
      case .cpu:
        entries.append(Entry(category: "CPU", label: "Usage", value: systemInfo.cpu.cpu.numerator.description, total: systemInfo.cpu.cpu.denominator.description))
        if options.verbose {
          for (index, core) in systemInfo.cpu.cores.enumerated() {
            entries.append(Entry(category: "CPU", label: "CPU \(index + 1)", value: core.numerator.description, total: core.denominator.description))
          }
          for (index, temp) in systemInfo.cpu.temperatures.enumerated() {
            if index == 0 {
              entries.append(Entry(category: "CPU", label: "Die Temperature \(type(of: options.temperatureUnit.scale).suffix)", value: nil, total: temp.value(inUnits: options.temperatureUnit).description))
            } else {
              entries.append(Entry(category: "CPU", label: "Core \(index) Temperature \(type(of: options.temperatureUnit.scale).suffix)", value: nil, total: temp.value(inUnits: options.temperatureUnit).description))
            }
          }
        }
      case .memory:
        entries.append(Entry(category: "Memory", label: "Usage", value: systemInfo.memory.numerator.description, total: systemInfo.memory.denominator.description))
      case .disks:
        for volume in systemInfo.volumes {
          entries.append(Entry(category: "Volume Usage", label: volume.name, value: volume.numerator.description, total: volume.denominator.description))
        }
      case .processes:
        entries.append(Entry(category: "Processes", label: "Count", value: nil, total: systemInfo.processes.description))
      case .network:
        for interface in systemInfo.networks {
          entries.append(Entry(category: "Networking", label: interface.name, value: interface.address, total: interface.family.description))
        }
      }
    }
    let text = entries.map { $0.description }.joined(separator: "\n")
    target.write(text)
  }
}

import Foundation
import SappiKit

struct JSONFormatter: Formatter {
  let encoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    return encoder
  }()

  func format<Target>(_ systemInfo: SystemInfo, withOptions _: SappiOptions, to target: inout Target) throws where Target: OutputStream {
    let data = try encoder.encode(systemInfo)
    target.write(data)
  }
}

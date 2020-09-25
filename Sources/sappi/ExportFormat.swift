import ArgumentParser
import SappiKit

enum ExportFormat: String, ExpressibleByArgument {
  case text
}

extension ExportFormat {
  var formatter: Formatter {
    switch self {
    case .text:
      return TextFormatter()
    }
  }
}

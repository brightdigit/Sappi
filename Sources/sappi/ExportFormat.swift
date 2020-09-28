import ArgumentParser
import SappiKit

public enum ExportFormat: String, ExpressibleByArgument {
  case text
  case json
  case csv
}

public extension ExportFormat {
  var formatter: Formatter {
    switch self {
    case .text:
      return TextFormatter()
    case .json:
      return JSONFormatter()
    case .csv:
      return CSVFormatter()
    }
  }
}

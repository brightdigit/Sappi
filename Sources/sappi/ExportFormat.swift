import ArgumentParser
import SappiKit

public enum ExportFormat: String, ExpressibleByArgument {
  /// Standard Text Format
  case text
  /// JSON Format
  case json
  /// CSV Format
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

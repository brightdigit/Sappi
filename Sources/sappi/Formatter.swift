import SappiKit

protocol Formatter {
  func format<Target: TextOutputStream>(_ systemInfo: SystemInfo, withOptions options: SappiOptions, to target: inout Target)
}

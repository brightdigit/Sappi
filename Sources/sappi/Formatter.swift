import Foundation
import SappiKit

public protocol Formatter {
  func format<Target: OutputStream>(_ systemInfo: SystemInfo, withOptions options: SappiOptions, to target: inout Target) throws
}

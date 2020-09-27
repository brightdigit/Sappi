import Foundation
import SappiKit

protocol BinaryOutputStream {
  func write(_ data: Data)
}

typealias OutputStream = TextOutputStream & BinaryOutputStream

protocol Formatter {
  func format<Target: OutputStream>(_ systemInfo: SystemInfo, withOptions options: SappiOptions, to target: inout Target) throws
}

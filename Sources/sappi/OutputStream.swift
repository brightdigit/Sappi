import Foundation

public protocol BinaryOutputStream {
  func write(_ data: Data)
}

public typealias OutputStream = TextOutputStream & BinaryOutputStream

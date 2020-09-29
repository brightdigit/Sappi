import Foundation

public struct AnyStream: OutputStream {
  public mutating func write(_ string: String) {
    stream.write(string)
  }

  public func write(_ data: Data) {
    stream.write(data)
  }

  var stream: OutputStream

  public init(_ stream: OutputStream) {
    self.stream = stream
  }
}

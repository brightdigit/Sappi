import Foundation

public final class FileHandleStream: OutputStream {
  let fileHandle: FileHandle

  internal init(_ fileHandle: FileHandle) {
    self.fileHandle = fileHandle
  }

  public func write(_ string: String) {
    write(Data(string.utf8))
  }

  public func write(_ data: Data) {
    fileHandle.write(data)
  }

  static var standardOutput = FileHandleStream(.standardOutput)
}

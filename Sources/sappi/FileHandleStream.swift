import Foundation

final class FileHandleStream: OutputStream {
  let fileHandle: FileHandle

  private init(_ fileHandle: FileHandle) {
    self.fileHandle = fileHandle
  }

  func write(_ string: String) {
    write(Data(string.utf8))
  }

  func write(_ data: Data) {
    fileHandle.write(data)
  }

  static var standardOutput = FileHandleStream(.standardOutput)
}

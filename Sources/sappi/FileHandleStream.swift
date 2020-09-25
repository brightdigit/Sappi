import Foundation

final class FileHandleStream: TextOutputStream {
  let fileHandle: FileHandle

  private init(_ fileHandle: FileHandle) {
    self.fileHandle = fileHandle
  }

  func write(_ string: String) {
    fileHandle.write(Data(string.utf8))
  }

  static let standardOutput = FileHandleStream(.standardOutput)
}

import Foundation

#if canImport(Darwin)
  import Darwin
#else
  typealias FourCharCode = UInt32
#endif

extension FourCharCode {
  init(fromString str: String) {
    precondition(str.count == 4)

    self = str.utf8.reduce(0) { sum, character in
      sum << 8 | UInt32(character)
    }
  }

  func toString() -> String {
    return String(describing: UnicodeScalar(self >> 24 & 0xFF)!) +
      String(describing: UnicodeScalar(self >> 16 & 0xFF)!) +
      String(describing: UnicodeScalar(self >> 8 & 0xFF)!) +
      String(describing: UnicodeScalar(self & 0xFF)!)
  }
}

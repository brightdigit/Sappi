import Foundation

#if !canImport(IOKit)
  public typealias IOByteCount32 = UInt32
  public typealias IOByteCount = IOByteCount32
#endif

struct SMCKeyData {
  typealias Bytes = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
                     UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
                     UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
                     UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
                     UInt8, UInt8, UInt8, UInt8)

  struct Version {
    var major: CUnsignedChar = 0
    var minor: CUnsignedChar = 0
    var build: CUnsignedChar = 0
    var reserved: CUnsignedChar = 0
    var release: CUnsignedShort = 0
  }

  struct LimitData {
    var version: UInt16 = 0
    var length: UInt16 = 0
    var cpuPLimit: UInt32 = 0
    var gpuPLimit: UInt32 = 0
    var memPLimit: UInt32 = 0
  }

  struct KeyInfo {
    var dataSize: IOByteCount = 0
    var dataType: UInt32 = 0
    var dataAttributes: UInt8 = 0
  }

  var key: UInt32 = 0
  var vers = Version()
  var pLimitData = LimitData()
  var keyInfo = KeyInfo()
  var padding: UInt16 = 0
  var result: UInt8 = 0
  var status: UInt8 = 0
  var data8: UInt8 = 0
  var data32: UInt32 = 0

  var bytes: Bytes = (UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
                      UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
                      UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
                      UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
                      UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
                      UInt8(0), UInt8(0))
}

public extension UInt16 {
  init(bytes: (UInt8, UInt8)) {
    self = UInt16(bytes.0) << 8 | UInt16(bytes.1)
  }
}

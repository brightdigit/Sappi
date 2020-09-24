extension Float {
  init?(_ bytes: [UInt8]) {
    self = bytes.withUnsafeBytes {
      $0.load(fromByteOffset: 0, as: Self.self)
    }
  }
}

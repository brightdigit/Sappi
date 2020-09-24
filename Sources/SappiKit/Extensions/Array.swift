extension Array {
  func firstMap<Value>(_ closure: (Element) -> Value?) -> Value? {
    for element in self {
      if let value = closure(element) {
        return value
      }
    }
    return nil
  }
}

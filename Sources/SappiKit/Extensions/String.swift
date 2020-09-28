import Foundation

extension String {
  /// parse tokens from a string, splitting by delimiters
  /// - parameters: delimiters, defined as strtok()
  internal func asTokens(delimiters: String = " \t\n\r") -> [String] {
    var array = [String]()
    guard let str = strdup(self) else { return array }
    var tok = strtok(str, delimiters)
    let NULL = UnsafeMutablePointer<Int8>(bitPattern: 0)
    while let found = tok {
      array.append(String(cString: found))
      tok = strtok(NULL, delimiters)
    } // end while
    free(str)
    return array
  } // end func

  internal var trimmed: String {
    var buf = [UInt8]()
    var trimming = true
    for character in utf8 {
      if trimming, character < 33 { continue }
      trimming = false
      buf.append(character)
    } // end ltrim
    while let last = buf.last, last < 33 {
      buf.removeLast()
    } // end rtrim
    buf.append(0)
    return String(cString: buf)
  } // end trim

  /// split a string into an array of lines
  internal var asLines: [String] {
    return split(separator: Character("\n"))
      .filter { $0.count > 0 }
      .map(String.init)
  }

  /// a quick buffer size definition
  internal static let szSTR = 4096

  /// treat the string as a file name and get the content by this name,
  /// will return nil if failed
  internal var asFile: String? {
    guard let file = fopen(self, "r") else { return nil }
    var content = [Int8]()
    let buf = UnsafeMutablePointer<Int8>.allocate(capacity: String.szSTR)
    memset(buf, 0, String.szSTR)
    var count = 0
    repeat {
      count = fread(buf, 1, String.szSTR, file)
      if count > 0 {
        let buffer = UnsafeBufferPointer(start: buf, count: count)
        content += Array(buffer)
      } // end if
    } while count > 0
    fclose(file)
    buf.deallocate()
    let ret = String(cString: content)
    return ret
  }

  /// equivalent to hasPrefix
  /// - parameters:
  ///   - prefix: the prefix string to looking for
  /// - returns:
  ///   true if the string has such a prefix
  internal func match(prefix: String) -> Bool {
    if prefix == self { return true }
    guard prefix.utf8.count > 0,
      utf8.count > prefix.utf8.count,
      let str = strdup(self)
    else {
      return false
    } // end str
    str.advanced(by: prefix.utf8.count).pointee = 0
    let matched = strcmp(str, prefix) == 0
    free(str)
    return matched
  } // end match

  internal func parse(definition: [(keyName: String, isString: Bool)]) -> [String: String] {
    let values = utf8.split(separator: 32).map { String($0) ?? "" }.filter { !$0.isEmpty }
    let size = min(values.count, definition.count)
    guard size > 0 else { return [:] }
    var content: [String: String] = [:]
    for index in 0 ... size - 1 {
      let key = definition[index].keyName
      let value = values[index]
      content[key] = value
    } // next i
    return content
  }
}

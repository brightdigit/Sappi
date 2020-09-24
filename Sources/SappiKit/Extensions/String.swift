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
    for c in utf8 {
      if trimming, c < 33 { continue }
      trimming = false
      buf.append(c)
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
    guard let f = fopen(self, "r") else { return nil }
    var content = [Int8]()
    let buf = UnsafeMutablePointer<Int8>.allocate(capacity: String.szSTR)
    memset(buf, 0, String.szSTR)
    var count = 0
    repeat {
      count = fread(buf, 1, String.szSTR, f)
      if count > 0 {
        let buffer = UnsafeBufferPointer(start: buf, count: count)
        content += Array(buffer)
      } // end if
    } while count > 0
    fclose(f)
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

  /// translate a labeless / space delimited string into a dictionry with the given definition
  /// - parameters:
  ///   - definition: an array for the expected string definition, each element is a name/type pair, which type only means string or non-string simply because only string needs quote in output
  /// - returns: dictionary
  internal func parse(definition: [(keyName: String, isString: Bool)]) -> [String: String] {
    let values = utf8.split(separator: 32).map { String($0) ?? "" }.filter { !$0.isEmpty }
    let size = min(values.count, definition.count)
    guard size > 0 else { return [:] }
    var content: [String: String] = [:]
    for i in 0 ... size - 1 {
      let key = definition[i].keyName
      let value = values[i]
      content[key] = value
    } // next i
    return content
  }
}

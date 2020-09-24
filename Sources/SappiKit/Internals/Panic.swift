import Foundation

enum Panic: Error {
  case deviceHasNoParent
  case deviceDoesNotConformToStorageDriver
  case deivceHasNoProperties
  case matchIOMediaFailed
  case sysCtlFailed
}

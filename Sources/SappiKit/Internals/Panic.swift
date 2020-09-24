import Foundation

enum Panic: Error {
  case DeviceHasNoParent
  case DeviceDoesNotConformToStorageDriver
  case DeivceHasNoProperties
  case MatchIOMediaFailed
  case SysCtlFailed
}

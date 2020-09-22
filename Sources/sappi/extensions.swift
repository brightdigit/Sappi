//
//  extensions.swift
//  StatsKit
//
//  Created by Serhiy Mytrovtsiy on 10/04/2020.
//  Using Swift 5.0.
//  Running on macOS 10.15.
//
//  Copyright © 2020 Serhiy Mytrovtsiy. All rights reserved.
//

import Foundation

#if os(macOS)
public enum Unit : Float {
    case byte     = 1
    case kilobyte = 1024
    case megabyte = 1048576
    case gigabyte = 1073741824
}

public struct Units {
    public let bytes: Int64
    
    public init(bytes: Int64) {
        self.bytes = bytes
    }
    
    public var kilobytes: Double {
        return Double(bytes) / 1_024
    }
    public var megabytes: Double {
        return kilobytes / 1_024
    }
    public var gigabytes: Double {
        return megabytes / 1_024
    }
    public var terabytes: Double {
        return gigabytes / 1_024
    }
    
    public func getReadableTuple() -> (String, String) {
        switch bytes {
        case 0..<1_024:
            return ("0", "KB/s")
        case 1_024..<(1_024 * 1_024):
            return (String(format: "%.0f", kilobytes), "KB/s")
        case 1_024..<(1_024 * 1_024 * 100):
            return (String(format: "%.1f", megabytes), "MB/s")
        case (1_024 * 1_024 * 100)..<(1_024 * 1_024 * 1_024):
            return (String(format: "%.0f", megabytes), "MB/s")
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return (String(format: "%.1f", gigabytes), "GB/s")
        default:
            return (String(format: "%.0f", kilobytes), "KB/s")
        }
    }
    
    public func getReadableSpeed() -> String {
        switch bytes {
        case 0..<1_024:
            return "0 KB/s"
        case 1_024..<(1_024 * 1_024):
            return String(format: "%.0f KB/s", kilobytes)
        case 1_024..<(1_024 * 1_024 * 100):
            return String(format: "%.1f MB/s", megabytes)
        case (1_024 * 1_024 * 100)..<(1_024 * 1_024 * 1_024):
            return String(format: "%.0f MB/s", megabytes)
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return String(format: "%.1f GB/s", gigabytes)
        default:
            return String(format: "%.0f KB/s", kilobytes)
        }
    }
    
    public func getReadableMemory() -> String {
        switch bytes {
        case 0..<1_024:
            return "0 KB"
        case 1_024..<(1_024 * 1_024):
            return String(format: "%.0f KB", kilobytes)
        case 1_024..<(1_024 * 1_024 * 1_024):
            return String(format: "%.0f MB", megabytes)
        case 1_024..<(1_024 * 1_024 * 1_024 * 1_024):
            return String(format: "%.2f GB", gigabytes)
        case (1_024 * 1_024 * 1_024 * 1_024)...Int64.max:
            return String(format: "%.2f TB", terabytes)
        default:
            return String(format: "%.0f KB", kilobytes)
        }
    }
}



extension Float {
    init?(_ bytes: [UInt8]) {
        self = bytes.withUnsafeBytes {
            return $0.load(fromByteOffset: 0, as: Self.self)
        }
    }
}

public extension Double {
    func roundTo(decimalPlaces: Int) -> String {
        return NSString(format: "%.\(decimalPlaces)f" as NSString, self) as String
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
//
//    func usageColor(reversed: Bool = false) -> NSColor {
//        let firstColor: NSColor = NSColor.systemBlue
//        let secondColor: NSColor = NSColor.orange
//        let thirdColor: NSColor = NSColor.red
//
//        if reversed {
//            switch self {
//            case 0.6...0.8:
//                return secondColor
//            case 0.8...1:
//                return firstColor
//            default:
//                return thirdColor
//            }
//        } else {
//            switch self {
//            case 0.6...0.8:
//                return secondColor
//            case 0.8...1:
//                return thirdColor
//            default:
//                return firstColor
//            }
//        }
//    }
//
//    func percentageColor(color: Bool) -> NSColor {
//        if !color {
//            return NSColor.textColor
//        }
//
//        switch self {
//        case 0.6...0.8:
//            return NSColor.systemOrange
//        case 0.8...1:
//            return NSColor.systemRed
//        default:
//            return NSColor.systemGreen
//        }
//    }
//
//    func batteryColor(color: Bool = false) -> NSColor {
//        switch self {
//        case 0.2...0.4:
//            if !color {
//                return NSColor.textColor
//            }
//            return NSColor.systemOrange
//        case 0.4...1:
//            if self == 1 {
//                return NSColor.textColor
//            }
//            if !color {
//                return NSColor.textColor
//            }
//            return NSColor.systemGreen
//        default:
//            return NSColor.systemRed
//        }
//    }
    
    func secondsToHoursMinutesSeconds() -> (Int?, Int?, Int?) {
        let hrs = self / 3600
        let mins = (self.truncatingRemainder(dividingBy: 3600)) / 60
        let seconds = (self.truncatingRemainder(dividingBy:3600)).truncatingRemainder(dividingBy:60)
        return (Int(hrs) > 0 ? Int(hrs) : nil , Int(mins) > 0 ? Int(mins) : nil, Int(seconds) > 0 ? Int(seconds) : nil)
    }
    
    func printSecondsToHoursMinutesSeconds() -> String {
        let time = self.secondsToHoursMinutesSeconds()
        
        switch time {
        case (nil, let x? , let y?):
            return "\(x)min \(y)sec"
        case (nil, let x?, nil):
            return "\(x)min"
        case (let x?, nil, nil):
            return "\(x)h"
        case (nil, nil, let x?):
            return "\(x)sec"
        case (let x?, nil, let z?):
            return "\(x)h \(z)sec"
        case (let x?, let y?, nil):
            return "\(x)h \(y)min"
        case (let x?, let y?, let z?):
            return "\(x)h \(y)min \(z)sec"
        default:
            return "n/a"
        }
    }
}


public extension Notification.Name {
    static let toggleSettings = Notification.Name("toggleSettings")
    static let toggleModule = Notification.Name("toggleModule")
    static let openSettingsView = Notification.Name("openSettingsView")
    static let switchWidget = Notification.Name("switchWidget")
    static let checkForUpdates = Notification.Name("checkForUpdates")
    static let changeCronInterval = Notification.Name("changeCronInterval")
    static let clickInSettings = Notification.Name("clickInSettings")
    static let updatePopupSize = Notification.Name("updatePopupSize")
}

public extension OperatingSystemVersion {
    func getFullVersion(separator: String = ".") -> String {
        return "\(majorVersion)\(separator)\(minorVersion)\(separator)\(patchVersion)"
    }
}

extension URL {
    func checkFileExist() -> Bool {
        return FileManager.default.fileExists(atPath: self.path)
    }
}

extension UInt32 {
    init(bytes: (UInt8, UInt8, UInt8, UInt8)) {
        self = UInt32(bytes.0) << 24 | UInt32(bytes.1) << 16 | UInt32(bytes.2) << 8 | UInt32(bytes.3)
    }
}

extension UInt16 {
    init(bytes: (UInt8, UInt8)) {
        self = UInt16(bytes.0) << 8 | UInt16(bytes.1)
    }
}

extension FourCharCode {
    init(fromString str: String) {
        precondition(str.count == 4)

        self = str.utf8.reduce(0) { sum, character in
            return sum << 8 | UInt32(character)
        }
    }
    
    func toString() -> String {
        return String(describing: UnicodeScalar(self >> 24 & 0xff)!) +
               String(describing: UnicodeScalar(self >> 16 & 0xff)!) +
               String(describing: UnicodeScalar(self >> 8  & 0xff)!) +
               String(describing: UnicodeScalar(self       & 0xff)!)
    }
}


public extension Array where Element : Equatable {
    func allEqual() -> Bool {
        if let firstElem = first {
            return !dropFirst().contains { $0 != firstElem }
        }
        return true
    }
}

public extension Array where Element : Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

public func asyncShell(_ args: String) {
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", args]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
}

public func syncShell(_ args: String) -> String {
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", args]
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.launch()
    task.waitUntilExit()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}


public func IsNewestVersion(currentVersion: String, latestVersion: String) -> Bool {
    let currentNumber = currentVersion.replacingOccurrences(of: "v", with: "")
    let latestNumber = latestVersion.replacingOccurrences(of: "v", with: "")
    
  
    let currentArray = currentNumber.split(separator: ".")
    let latestArray = latestNumber.split(separator: ".")
    
    let current = Version(major: Int(currentArray[0]) ?? 0, minor: Int(currentArray[1]) ?? 0, patch: Int(currentArray[2]) ?? 0)
    let latest = Version(major: Int(latestArray[0]) ?? 0, minor: Int(latestArray[1]) ?? 0, patch: Int(latestArray[2]) ?? 0)
    
    if latest.major > current.major {
        return true
    }
    
    if latest.minor > current.minor && latest.major >= current.major {
        return true
    }
    
    if latest.patch > current.patch && latest.minor >= current.minor && latest.major >= current.major {
        return true
    }
    
    return false
}

public typealias updateInterval = String
public enum updateIntervals: updateInterval {
    case atStart = "At start"
    case separator_1 = "separator_1"
    case oncePerDay = "Once per day"
    case oncePerWeek = "Once per week"
    case oncePerMonth = "Once per month"
    case separator_2 = "separator_2"
    case never = "Never"
}
extension updateIntervals: CaseIterable {}


public func getIOParent(_ obj: io_registry_entry_t) -> io_registry_entry_t? {
    var parent: io_registry_entry_t = 0
    
    if IORegistryEntryGetParentEntry(obj, kIOServicePlane, &parent) != KERN_SUCCESS {
        return nil
    }
    
    if (IOObjectConformsTo(parent, "IOBlockStorageDriver") == 0) {
        IOObjectRelease(parent)
        return nil
    }
    
    return parent
}

public func fetchIOService(_ name: String) -> [NSDictionary]? {
    var iterator: io_iterator_t = io_iterator_t()
    var obj: io_registry_entry_t = 1
    var list: [NSDictionary] = []
    
    let result = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching(name), &iterator)
    if result == kIOReturnSuccess {
        while obj != 0 {
            obj = IOIteratorNext(iterator)
            if let props = getIOProperties(obj) {
                list.append(props)
            }
            IOObjectRelease(obj)
        }
        IOObjectRelease(iterator)
    }
    
    return list.isEmpty ? nil : list
}

public func getIOProperties(_ entry: io_registry_entry_t) -> NSDictionary? {
    var properties: Unmanaged<CFMutableDictionary>? = nil
    
    if IORegistryEntryCreateCFProperties(entry, &properties, kCFAllocatorDefault, 0) != kIOReturnSuccess {
        return nil
    }
    
    defer {
        properties?.release()
    }
    
    return properties?.takeUnretainedValue()
}


public struct Log: TextOutputStream {
    public func write(_ string: String) {
        let fm = FileManager.default
        let log = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("log.txt")
        if let handle = try? FileHandle(forWritingTo: log) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? string.data(using: .utf8)?.write(to: log)
        }
    }
}

public func LocalizedString(_ key: String, _ params: String..., comment: String = "") -> String {
    var string = NSLocalizedString(key, comment: comment)
    if !params.isEmpty {
        for (index, param) in params.enumerated() {
            string = string.replacingOccurrences(of: "%\(index)", with: param)
        }
    }
    return string
}
#endif

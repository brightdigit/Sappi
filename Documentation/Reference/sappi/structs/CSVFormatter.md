**STRUCT**

# `CSVFormatter`

```swift
public struct CSVFormatter: Formatter
```

## Methods
### `format(_:withOptions:to:)`

```swift
public func format<Target>(
  _ systemInfo: SystemInfo,
  withOptions options: SappiOptions,
  to target: inout Target
) throws where Target: TextOutputStream, Target: BinaryOutputStream
```

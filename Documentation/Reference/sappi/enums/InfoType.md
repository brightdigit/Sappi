**ENUM**

# `InfoType`

```swift
public enum InfoType: String, ExpressibleByArgument, CaseIterable, Comparable
```

Various Metrics, you can request.

## Cases
### `cpu`

```swift
case cpu
```

CPU and Core Usage. Includes temperature information in verbose mode.

### `memory`

```swift
case memory
```

Memory Usage.

### `disks`

```swift
case disks
```

Disk Volume Usage.

### `processes`

```swift
case processes
```

Number of Active Processes.

### `network`

```swift
case network
```

Each connected network and address.

## Methods
### `<(_:_:)`

```swift
public static func < (lhs: InfoType, rhs: InfoType) -> Bool
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | A value to compare. |
| rhs | Another value to compare. |
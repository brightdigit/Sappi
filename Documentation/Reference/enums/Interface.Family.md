**ENUM**

# `Interface.Family`

```swift
public enum Family: Int
```

The network interface family (IPv4 or IPv6).

## Cases
### `ipv4`

```swift
case ipv4
```

IPv4.

### `ipv6`

```swift
case ipv6
```

IPv6.

### `other`

```swift
case other
```

Used in case of errors.

## Methods
### `toString()`

```swift
public func toString() -> String
```

String representation of the address family.

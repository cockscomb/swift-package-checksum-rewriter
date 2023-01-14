# swift-package-checksum-rewriter

## Usage

### Adding the swift-package-checksum-rewriter plugin as a dependency

```swift
    dependencies: [
        ...
        .package(url: "https://github.com/cockscomb/swift-package-checksum-rewriter", from: "0.1.0"),
    ],
```

### Rewirete Package.swift

```bash
$ swift package rewrite-package-binary-target --url={URL to the binary} --checksum={checksum of the binary} Package.swift {binary target name}
```

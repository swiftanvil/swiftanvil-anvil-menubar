# ``AnvilMenuBar``

Simplify macOS menu bar extras with dynamic items and built-in actions.

## Overview

`AnvilMenuBar` provides an observable model for `MenuBarExtra` content:

```swift
@State private var menuBar = AnvilMenuBar(items: [
    .button("Open", action: .openWindow()),
    .separator,
    .button("Quit", action: .quit),
])

MenuBarExtra("MyApp", systemImage: "hammer") {
    menuBar.content
}
```

## Topics

### Core Types

- ``AnvilMenuBar``
- ``MenuBarItem``
- ``MenuBarAction``

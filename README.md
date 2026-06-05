# AnvilMenuBar

Simplify macOS menu bar extras with dynamic items and built-in actions.

## Features

- **Dynamic items**: Insert, remove, and replace menu items at runtime
- **Built-in actions**: `openWindow`, `openSettings`, `quit` — no boilerplate
- **SwiftUI-native**: Works inside `MenuBarExtra` with standard SwiftUI views
- **Zero dependencies**: SwiftUI + AppKit only

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swiftanvil/swiftanvil-anvil-menubar.git", from: "1.0.0"),
]
```

## Usage

```swift
import SwiftUI
import AnvilMenuBar

@main
struct MyApp: App {
    @State private var menuBar = AnvilMenuBar(items: [
        .button("Open Main Window", action: .openWindow()),
        .button("Preferences", action: .openSettings),
        .separator,
        .button("Quit", action: .quit),
    ])

    var body: some Scene {
        WindowGroup { ContentView() }

        MenuBarExtra("MyApp", systemImage: "hammer") {
            menuBar.content
        }
    }
}
```

### Dynamic Items

```swift
menuBar.append(.button("New Item", action: .custom { print("tapped") }))
menuBar.remove(at: 0)
menuBar.replace(at: 1, with: .separator)
```

### Submenus

```swift
.submenu("More", items: [
    .button("About", action: .openSettings),
    .button("Help", action: .openWindow(id: "help")),
])
```

## Platforms

- macOS 15+

## License

MIT

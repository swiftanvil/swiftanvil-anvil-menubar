import Observation
import SwiftUI

/// An observable model that manages menu bar items and renders them as SwiftUI views.
///
/// ```swift
/// @State private var menuBar = AnvilMenuBar(items: [
///     .button("Open", action: .openWindow()),
///     .separator,
///     .button("Quit", action: .quit),
/// ])
///
/// MenuBarExtra("MyApp", systemImage: "hammer") {
///     menuBar.content
/// }
/// ```
@Observable
public final class AnvilMenuBar {
    public var items: [MenuBarItem]

    /// Creates a menu bar with the given items.
    public init(items: [MenuBarItem] = []) {
        self.items = items
    }

    // MARK: - Dynamic Mutation

    /// Inserts an item at the specified index.
    public func insert(_ item: MenuBarItem, at index: Int) {
        let clamped = max(0, min(index, items.count))
        items.insert(item, at: clamped)
    }

    /// Removes the item at the specified index.
    @discardableResult
    public func remove(at index: Int) -> MenuBarItem? {
        guard items.indices.contains(index) else { return nil }
        return items.remove(at: index)
    }

    /// Replaces the item at the specified index.
    public func replace(at index: Int, with item: MenuBarItem) {
        guard items.indices.contains(index) else { return }
        items[index] = item
    }

    /// Appends an item to the end.
    public func append(_ item: MenuBarItem) {
        items.append(item)
    }

    // MARK: - Content View

    /// A SwiftUI view that renders all menu items.
    ///
    /// Use this inside a `MenuBarExtra` scene.
    public var content: some View {
        MenuBarContent(items: items)
    }
}

// MARK: - MenuBarContent View

private struct MenuBarContent: View {
    let items: [MenuBarItem]

    var body: some View {
        ForEach(Array(items.enumerated()), id: \.offset) { _, item in
            switch item {
            case let .button(label, systemImage, action):
                Button {
                    perform(action)
                } label: {
                    if let image = systemImage {
                        Label(label, systemImage: image)
                    } else {
                        Text(label)
                    }
                }

            case .toggle(let label, var isOn):
                Toggle(label, isOn: Binding(
                    get: { isOn },
                    set: { isOn = $0 }
                ))

            case .separator:
                Divider()

            case let .submenu(label, subitems):
                Menu(label) {
                    MenuBarContent(items: subitems)
                }
            }
        }
    }

    private func perform(_ action: MenuBarAction) {
        switch action {
        case .openWindow:
            #if canImport(AppKit)
                NSApp.activate(ignoringOtherApps: true)
            #endif

        case .openSettings:
            #if canImport(AppKit)
                NSApp.sendAction(Selector("showPreferencesWindow:"), to: nil, from: nil)
            #endif

        case .quit:
            #if canImport(AppKit)
                NSApp.terminate(nil)
            #endif

        case let .custom(closure):
            closure()
        }
    }
}

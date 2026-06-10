import SwiftUI

/// A single item in a menu bar menu.
///
/// ```swift
/// .button("Open", systemImage: "window", action: .openWindow())
/// .toggle("Dark Mode", isOn: $isDarkMode)
/// .separator
/// .submenu("More", items: [.button("About", action: .openSettings)])
/// ```
public enum MenuBarItem: Equatable, Sendable {
    case button(label: String, systemImage: String? = nil, action: MenuBarAction)
    case toggle(label: String, isOn: Bool)
    case separator
    case submenu(label: String, items: [MenuBarItem])

    public static func == (lhs: MenuBarItem, rhs: MenuBarItem) -> Bool {
        switch (lhs, rhs) {
        case let (.button(l1, l2, l3), .button(r1, r2, r3)):
            l1 == r1 && l2 == r2 && l3 == r3
        case let (.toggle(l1, l2), .toggle(r1, r2)):
            l1 == r1 && l2 == r2
        case (.separator, .separator):
            true
        case let (.submenu(l1, l2), .submenu(r1, r2)):
            l1 == r1 && l2 == r2
        default:
            false
        }
    }
}

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
        case (.button(let l1, let l2, let l3), .button(let r1, let r2, let r3)):
            return l1 == r1 && l2 == r2 && l3 == r3
        case (.toggle(let l1, let l2), .toggle(let r1, let r2)):
            return l1 == r1 && l2 == r2
        case (.separator, .separator):
            return true
        case (.submenu(let l1, let l2), .submenu(let r1, let r2)):
            return l1 == r1 && l2 == r2
        default:
            return false
        }
    }
}

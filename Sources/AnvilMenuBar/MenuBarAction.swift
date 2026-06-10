import Foundation

/// Built-in actions for menu bar items.
///
/// Use `MenuBarAction` to wire menu items to common app behaviors without
/// writing boilerplate.
///
/// ```swift
/// .button("Quit", action: .quit)
/// .button("Preferences", action: .openSettings)
/// ```
public enum MenuBarAction: Equatable, Sendable {
    /// Open the app's main window (or a specific window by ID).
    case openWindow(id: String? = nil)

    /// Open the app's Settings / Preferences window.
    case openSettings

    /// Quit the application.
    case quit

    /// A custom closure action.
    ///
    /// Note: closures are not `Equatable`; two `.custom` actions are never equal.
    case custom(@Sendable () -> Void)

    public static func == (lhs: MenuBarAction, rhs: MenuBarAction) -> Bool {
        switch (lhs, rhs) {
        case let (.openWindow(a), .openWindow(b)): a == b
        case (.openSettings, .openSettings): true
        case (.quit, .quit): true
        default: false
        }
    }
}

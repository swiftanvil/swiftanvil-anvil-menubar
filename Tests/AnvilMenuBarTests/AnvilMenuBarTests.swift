import Foundation
import Testing
@testable import AnvilMenuBar

@Suite("AnvilMenuBar")
struct AnvilMenuBarTests {
    @Test("creates button item")
    func buttonItem() {
        let item = MenuBarItem.button(label: "Open", systemImage: "window", action: .openWindow())

        if case let .button(label, image, action) = item {
            #expect(label == "Open")
            #expect(image == "window")
            #expect(action == .openWindow())
        } else {
            Issue.record("Expected button item")
        }
    }

    @Test("creates toggle item")
    func toggleItem() {
        let item = MenuBarItem.toggle(label: "Dark Mode", isOn: true)

        if case let .toggle(label, isOn) = item {
            #expect(label == "Dark Mode")
            #expect(isOn == true)
        } else {
            Issue.record("Expected toggle item")
        }
    }

    @Test("creates separator item")
    func separatorItem() {
        let item = MenuBarItem.separator
        #expect(item == .separator)
    }

    @Test("creates submenu item")
    func submenuItem() {
        let item = MenuBarItem.submenu(label: "More", items: [
            .button(label: "About", action: .openSettings)
        ])

        if case let .submenu(label, items) = item {
            #expect(label == "More")
            #expect(items.count == 1)
        } else {
            Issue.record("Expected submenu item")
        }
    }

    @Test("action equality")
    func actionEquality() {
        #expect(MenuBarAction.openWindow() == MenuBarAction.openWindow())
        #expect(MenuBarAction.openWindow(id: "help") == MenuBarAction.openWindow(id: "help"))
        #expect(MenuBarAction.openWindow(id: "a") != MenuBarAction.openWindow(id: "b"))
        #expect(MenuBarAction.openSettings == MenuBarAction.openSettings)
        #expect(MenuBarAction.quit == MenuBarAction.quit)
        #expect(MenuBarAction.openSettings != MenuBarAction.quit)
    }

    @Test("dynamic insert")
    func dynamicInsert() {
        let menuBar = AnvilMenuBar(items: [.separator])
        menuBar.insert(.button(label: "New", action: .quit), at: 0)

        #expect(menuBar.items.count == 2)
        if case let .button(label, _, _) = menuBar.items[0] {
            #expect(label == "New")
        } else {
            Issue.record("Expected button at index 0")
        }
    }

    @Test("dynamic remove")
    func dynamicRemove() {
        let menuBar = AnvilMenuBar(items: [
            .button(label: "A", action: .quit),
            .separator
        ])
        let removed = menuBar.remove(at: 1)

        #expect(menuBar.items.count == 1)
        #expect(removed == .separator)
    }

    @Test("dynamic replace")
    func dynamicReplace() {
        let menuBar = AnvilMenuBar(items: [
            .button(label: "Old", action: .quit)
        ])
        menuBar.replace(at: 0, with: .button(label: "New", action: .openSettings))

        if case let .button(label, _, _) = menuBar.items[0] {
            #expect(label == "New")
        } else {
            Issue.record("Expected replaced button")
        }
    }

    @Test("append adds to end")
    func append() {
        let menuBar = AnvilMenuBar(items: [.separator])
        menuBar.append(.button(label: "End", action: .quit))

        #expect(menuBar.items.count == 2)
        if case let .button(label, _, _) = menuBar.items[1] {
            #expect(label == "End")
        } else {
            Issue.record("Expected button at end")
        }
    }

    @Test("remove out of bounds returns nil")
    func removeOutOfBounds() {
        let menuBar = AnvilMenuBar(items: [])
        let removed = menuBar.remove(at: 0)

        #expect(removed == nil)
    }

    @Test("replace out of bounds is no-op")
    func replaceOutOfBounds() {
        let menuBar = AnvilMenuBar(items: [])
        menuBar.replace(at: 5, with: .separator)

        #expect(menuBar.items.isEmpty)
    }

    @Test("insert clamps negative index to 0")
    func insertClampsNegative() {
        let menuBar = AnvilMenuBar(items: [.separator])
        menuBar.insert(.button(label: "First", action: .quit), at: -10)

        if case let .button(label, _, _) = menuBar.items[0] {
            #expect(label == "First")
        } else {
            Issue.record("Expected button at index 0")
        }
    }

    @Test("insert clamps beyond count to end")
    func insertClampsBeyondCount() {
        let menuBar = AnvilMenuBar(items: [.separator])
        menuBar.insert(.button(label: "Last", action: .quit), at: 100)

        #expect(menuBar.items.count == 2)
        if case let .button(label, _, _) = menuBar.items[1] {
            #expect(label == "Last")
        } else {
            Issue.record("Expected button at end")
        }
    }
}

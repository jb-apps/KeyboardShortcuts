//
//  KeyboardShortcuts+View.swift
//  LensOCR
//
//  Created by Jonathan Benavides Vallejo on 27.03.23.
//

import AppKit
import KeyboardShortcuts
import SwiftUI

// MARK: - SwiftUI Helpers
extension KeyboardShortcuts.Shortcut {

    @available(iOS 14.0, macOS 11.0, *)
    var swiftUI: SwiftUI.KeyboardShortcut? {
        guard let key = keyEquivalent.first else { return nil }
        return .init(.init(key), modifiers: modifiers.swiftUI)
    }

}

@available(macOS 10.15, *)
extension NSEvent.ModifierFlags {
    var swiftUI: SwiftUI.EventModifiers {
        var modifiers: SwiftUI.EventModifiers = []
        if contains(.shift) {
            modifiers.insert(.shift)
        }
        if contains(.command) {
            modifiers.insert(.command)
        }
        if contains(.capsLock) {
            modifiers.insert(.capsLock)
        }
//        if contains(.function) {
//            modifiers.insert(.function)
//        }
        if contains(.option) {
            modifiers.insert(.option)
        }
        if contains(.control) {
            modifiers.insert(.control)
        }
        return modifiers
    }
}

@available(iOS 14.0, macOS 11.0, *)
extension View {

    @ViewBuilder
    /// Assigns the global keyboard shortcut to the modified control.
    ///
    /// Only assigns a keyboard shortcut, if one was defined (or it has a default shortcut).
    ///
    /// - Parameter shortcut: Strongly-typed name of the shortcut
    public func keyboardShortcut(_ shortcut: KeyboardShortcuts.Name) -> some View {
        if let shortcut = (shortcut.shortcut ?? shortcut.defaultShortcut)?.swiftUI {
            self.keyboardShortcut(shortcut)
        } else {
            self
        }
    }

}

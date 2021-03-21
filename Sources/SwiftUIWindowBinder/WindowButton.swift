//
//  WindowButton.swift
//  SwiftUIWindowBinder
//
//  Created by Paul Bates on 10/12/20.
//

import os.log
import SwiftUI

/// A button that is able to expose its host window when interacting the the button
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public struct WindowButton<Label> : View where Label : View {
    /// Host window based on presentation of view
    @State private var window: Window? = nil

    /// Action handler with supplied window
    private let action: (Window) -> Void

    /// Label view hierarchy
    private let label: () -> Label

    /// Creates a button that displays a custom label, and action where a host window is passed.
    ///
    /// - Parameters:
    ///   - action: The action to perform when the user triggers the button.
    ///   - label: A view that describes the purpose of the button's `action`.
    public init(action: @escaping (Window) -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.action = action
        self.label = label
    }

    // MARK: View

    public var body: some View {
        Button(action: {
            guard let window = self.window else {
                os_log(.error, "Button action cancelled: window is nil")
                return
            }

            action(window)
        }, label: {
            // Add bindindable view to hierachy to tap UIKit/AppKit view hierarchy
            WindowBinder(window: $window) {
                // Original label
                label()
            }
        })
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension WindowButton where Label == Text {
    /// Creates a button that generates its label from a localized string key.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// localized key similar to ``Text/init(_:tableName:bundle:comment:)``. See
    /// ``Text`` for more information about localizing strings.
    ///
    /// To initialize a button with a string variable, use
    /// ``Button/init(_:action:)-lpm7`` instead.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///     the purpose of the button's `action`.
    ///   - action: The action to perform when the user triggers the button.
    init(_ titleKey: LocalizedStringKey, action: @escaping (Window) -> Void) {
        self.init(action: action, label: { Text(titleKey) })
    }

    /// Creates a button that generates its label from a string.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// title similar to ``Text/init(_:)-9d1g4``. See ``Text`` for more
    /// information about localizing strings.
    ///
    /// To initialize a button with a localized string key, use
    /// ``Button/init(_:action:)-1asy`` instead.
    ///
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - action: The action to perform when the user triggers the button.
    init<S>(_ title: S, action: @escaping (Window) -> Void) where S : StringProtocol {
        self.init(action: action, label: { Text(title) })
    }
}

#if DEBUG
struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(
                    configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue))
    }
}

struct WindowButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WindowButton(action: { window in
                let title = "Hello"
                let message = "Hello Mum"
                let buttonTitle = "Bye!"

                // In this example it know ``Alert`` can be used from SwiftUI
                // Instead this demonstrates the accessibity of the window tersely

                #if canImport(UIKit)

                // Use UIAlertController instead of Alert
                let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: buttonTitle, style: .cancel))

                window.rootViewController!.present(controller, animated: true) { }

                #elseif canImport(AppKit)

                // Use NSAlert instead of Alert
                let alert = NSAlert()
                alert.messageText = title
                alert.informativeText = message
                alert.addButton(withTitle: buttonTitle)

                alert.beginSheetModal(for: window)

                #endif
            }, label: {
                Text("Hello")
            })
            .buttonStyle(BlueButtonStyle())
            .padding()
        }
    }
}
#endif

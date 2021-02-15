//
//  APNavigationStyleModifierEnvironment.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationStyleModifierEnvironmentKey: EnvironmentKey {
    public static let defaultValue = _APNavigationViewStyleModifier(APStackNavigationViewStyle())
}

extension EnvironmentValues {
    public var apNavigationStyleModifier: _APNavigationViewStyleModifier  {
        get {
            return self[APNavigationStyleModifierEnvironmentKey.self]
        }
        set {
            self[APNavigationStyleModifierEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        environment(\.apNavigationStyleModifier, _APNavigationViewStyleModifier(style))
    }
}

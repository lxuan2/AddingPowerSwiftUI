//
//  APNavigationStyleModiferEnvironment.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationStyleModiferEnvironmentKey: EnvironmentKey {
    public static let defaultValue = _APNavigationViewStyleModifier(APStackNavigationViewStyle())
}

extension EnvironmentValues {
    public var apNavigationStyleModifer: _APNavigationViewStyleModifier  {
        get {
            return self[APNavigationStyleModiferEnvironmentKey.self]
        }
        set {
            self[APNavigationStyleModiferEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        environment(\.apNavigationStyleModifer, _APNavigationViewStyleModifier(style))
    }
}

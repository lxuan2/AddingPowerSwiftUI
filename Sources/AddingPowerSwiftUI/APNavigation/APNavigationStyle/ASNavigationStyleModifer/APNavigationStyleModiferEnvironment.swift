//
//  APNavigationStyleModiferEnvironment.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationStyleModiferEnvironmentKey: EnvironmentKey {
    public static let defaultValue = APNavigationStyleModifier(APStackNavigationStyle())
}

extension EnvironmentValues {
    public var apNavigationStyleModifer: APNavigationStyleModifier  {
        get {
            return self[APNavigationStyleModiferEnvironmentKey.self]
        }
        set {
            self[APNavigationStyleModiferEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    public func apNavigationStyle<S: APNavigationStyle>(_ style: S) -> some View {
        environment(\.apNavigationStyleModifer, APNavigationStyleModifier(style))
    }
}

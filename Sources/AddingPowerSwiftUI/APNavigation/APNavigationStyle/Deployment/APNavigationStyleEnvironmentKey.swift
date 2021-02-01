//
//  APNavigationStyleEnvironmentKey.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationStyleEnvironmentKey: EnvironmentKey {
    public static let defaultValue = APAnyNavigationStyle(APStackNavigationStyle())
}

extension EnvironmentValues {
    public var apNavigationStyle: APAnyNavigationStyle  {
        get {
            return self[APNavigationStyleEnvironmentKey.self]
        }
        set {
            self[APNavigationStyleEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    public func apNavigationStyle<S: APNavigationStyle>(_ style: S) -> some View {
        environment(\.apNavigationStyle, APAnyNavigationStyle(style))
    }
}

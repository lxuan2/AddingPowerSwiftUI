//
//  APNavigationViewStyleModifier.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APAnyAPNavigationViewStyle: APStyle {
    let content: (APNavigationViewStyleConfiguration) -> APAnyRepresentable
    
    public func _body(configuration: APNavigationViewStyleConfiguration) -> some View {
        content(configuration)
    }
    
    public init<S: APNavigationViewStyle>(_ s: S) {
        self.content = {
            APAnyRepresentable(s.makeBody(configuration: $0))
        }
    }
}

public struct APAnyNavigationViewStyle: EnvironmentKey {
    public static var defaultValue = APAnyAPNavigationViewStyle(APStackNavigationViewStyle())
}

extension EnvironmentValues {
    public var apNavigationStyle: APAnyAPNavigationViewStyle {
        get { self[APAnyNavigationViewStyle.self] }
        set { self[APAnyNavigationViewStyle.self] = newValue }
    }
}

extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        environment(\.apNavigationStyle, APAnyAPNavigationViewStyle(style))
    }
}

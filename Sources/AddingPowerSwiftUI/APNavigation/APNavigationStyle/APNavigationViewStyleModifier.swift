//
//  APNavigationViewStyleModifier.swift
//  
//
//

import SwiftUI

struct APNavigationViewStyleKey: APStyleKey {
    static func makeDefault(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationViewStyle().makeBody(configuration: configuration)
    }
}

struct APNavigationViewStyleModifier<Style: APNavigationViewStyle>: ViewModifier {
    let style: Style
    
    func body(content: Content) -> some View {
        content.style(APNavigationViewStyleKey.self, style.makeBody)
    }
}

extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        modifier(APNavigationViewStyleModifier(style: style))
    }
}

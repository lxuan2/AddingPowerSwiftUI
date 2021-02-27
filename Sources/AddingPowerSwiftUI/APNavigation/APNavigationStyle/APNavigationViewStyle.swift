//
//  APNavigationViewStyle.swift
//  
//
//

import SwiftUI

// MARK: - APNavigationViewStyle

public protocol APNavigationViewStyle {
    associatedtype Body : View
    func makeBody(configuration: APNavigationViewStyleConfiguration) -> Body
}

// MARK: - APNavigationViewStyleConfiguration

public struct APNavigationViewStyleConfiguration {
    public struct Content: View {
        public typealias Body = Never
    }
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    init() {
        self.content = Content()
    }
}

extension APNavigationViewStyleConfiguration.Content: APStaticView {}

// MARK: - APNavigationViewStyleKey

struct APNavigationViewStyleKey: APStyleKey {
    static func makeDefault(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationViewStyle().makeBody(configuration: configuration)
    }
}

// MARK: - APNavigationViewStyleModifier
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

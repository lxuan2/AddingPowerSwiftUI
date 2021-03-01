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
    public struct Content: APCanvas {
        public typealias Body = Never
    }
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    init() {
        self.content = Content()
    }
}

// MARK: - APNavigationViewStyleCanvas

struct APNavigationViewStyleCanvas: APStyleCanvas {
    static func makeDefault(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationViewStyle().makeBody(configuration: configuration)
    }
}

// MARK: - APNavigationViewStyleModifier
extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        self.style(APNavigationViewStyleCanvas.self, style.makeBody)
    }
}

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
        @Environment(APNavigationViewContentKey.self) private var _source
        
        public var body: some View {
            _source
        }
        
        public var source: Environment<_VariadicView.Children?> {
            Environment(APNavigationViewContentKey.self)
        }
    }
    
    public var content: APNavigationViewStyleConfiguration.Content {
        Content()
    }
    
    init() {}
}

// MARK: - APNavigationViewStyleModifier

struct APNavigationViewStyleWriter<S: APNavigationViewStyle>: ViewModifier {
    var style: S
    
    func body(content: Content) -> some View {
        content.style(APNavigationViewStyleKey.self, body: style.makeBody)
    }
}

extension View {
    public func apNavigationViewStyle<S: APNavigationViewStyle>(_ style: S) -> some View {
        modifier(APNavigationViewStyleWriter(style: style))
    }
}

// MARK: - APNavigationViewContentKey

struct APNavigationViewContentKey: APStaticSourceKey {}

// MARK: - APNavigationViewStyleKey

struct APNavigationViewStyleKey: APStyleKey {
    static func makeDefault(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationViewStyle().makeBody(configuration: configuration)
    }
}

//
//  APStyleContent.swift
//  
//
//  Created by Xuan Li on 2/18/21.
//

import SwiftUI

public struct APStyleContent<Style: APStyle>: ViewModifier {
    @Environment var style: Style
    public var configuration:(Style.Configuration.Content) -> Style.Configuration
    
    public init(_ keyPath: WritableKeyPath<EnvironmentValues, Style>, configuration: @escaping (Style.Configuration.Content) -> Style.Configuration) {
        self.configuration = configuration
        self._style = .init(keyPath)
    }
    public func body(content: Content) -> some View {
        style.makeBody(configuration: configuration(content))
    }
    
}

extension View {
    @inlinable public func style<S: APStyle>(_ keyPath: WritableKeyPath<EnvironmentValues, S>, _ style: S) -> some View {
        environment(keyPath, style)
    }
    
    @inlinable public func applyStyle<S: APStyle>(_ keyPath: WritableKeyPath<EnvironmentValues, S>, configuration: @escaping (S.Configuration.Content) -> S.Configuration) -> some View {
        modifier(APStyleContent(keyPath, configuration: configuration))
    }
}

//
//  APStackNavigationViewStyle.swift
//  
//
//

import SwiftUI

public struct APStackNavigationViewStyle: APNavigationViewStyle {
    public func makeBody(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationView(_source: configuration.content.source)
    }
    
    public init() {}
}

public struct APStackNavigationView: View {
    @Environment var source: _VariadicView.Children?
    
    public var body: some View {
        APUnbridgedNavigationView(content: source?[0], areLargeTitlesEnabled: true)
    }
    
    public init(_source: Environment<_VariadicView.Children?>) {
        self._source = _source
    }
}

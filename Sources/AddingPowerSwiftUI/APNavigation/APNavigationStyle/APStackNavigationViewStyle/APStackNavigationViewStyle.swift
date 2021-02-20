//
//  APStackNavigationViewStyle.swift
//  
//
//

import SwiftUI

public struct APStackNavigationViewStyle: APNavigationViewStyle {
    public func makeBody(configuration: APNavigationViewStyleConfiguration) -> some View {
        APVariadicView.Tree(root: APStackNavigationView(), content: configuration.content)
    }
    
    public init() {}
}

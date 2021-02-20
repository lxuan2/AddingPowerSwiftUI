//
//  APNavigationView.swift
//  
//
//

import SwiftUI

public struct APNavigationView<Content: APView>: View {
    let content: Content
    
    public var body: some View {
        content
            .applyStyle(\.apNavigationStyle) {
                APNavigationViewStyleConfiguration($0)
            }
            .edgesIgnoringSafeArea(.all)
    }
    
    public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

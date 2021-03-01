//
//  APNavigationView.swift
//  
//
//

import SwiftUI

public struct APNavigationView<Content: APView>: View {
    let content: Content
    
    public var body: some View {
        APResolvedNavigationView()
            .fill(APNavigationViewStyleConfiguration.Content.self, with: content)
    }
    
    public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

struct APResolvedNavigationView: View {
    var body: some View {
        APNavigationViewStyleCanvas
            .makeBody(configuration: APNavigationViewStyleConfiguration())
            .edgesIgnoringSafeArea(.all)
    }
}

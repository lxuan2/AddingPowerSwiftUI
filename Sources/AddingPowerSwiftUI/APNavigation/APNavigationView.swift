//
//  APNavigationView.swift
//  
//
//

import SwiftUI

public struct APNavigationView<Content: View>: View {
    let content: Content
    
    public var body: some View {
        APResolvedNavigationView()
            .fill(APNavigationViewContentKey.self, source: content)
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

struct APResolvedNavigationView: View {
    var body: some View {
        APStyleView(key: APNavigationViewStyleKey.self,
                    configuration: APNavigationViewStyleConfiguration())
    }
}

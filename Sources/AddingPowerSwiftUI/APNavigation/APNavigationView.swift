//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationView<Content: View>: View {
    let content: Content
    @Environment(\.apNavigationStyleModifier) var style
    
    public var body: some View {
        content
            .modifier(APNavigationViewStyleModifier())
            .edgesIgnoringSafeArea(.all)
    }
    
    public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

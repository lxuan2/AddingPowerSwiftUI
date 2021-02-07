//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationView<Content: APView>: View {
    let content: Content
    @Environment(\.apNavigationStyleModifer) var style
    
    public var body: some View {
        Spacer()
            .modifier(content)
            .modifier(APNavigationViewStyleModifier())
            .edgesIgnoringSafeArea(.all)
    }
    
    public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationView<Content: View>: View {
    let content: Content
    @Environment(\.apNavigationStyleModifer) var styleModifer
    
    public var body: some View {
        content
            .modifier(styleModifer)
            .edgesIgnoringSafeArea(.all)
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

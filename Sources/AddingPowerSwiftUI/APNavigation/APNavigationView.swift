//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationView<Content: View>: View {
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

//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationView<Content: View>: View {
    let content: Content
    @Environment(\.apNavigationStyle) var style
    
    public var body: some View {
        style.body(configuration: APNavigationViewStyleConfiguration(content))
    }
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

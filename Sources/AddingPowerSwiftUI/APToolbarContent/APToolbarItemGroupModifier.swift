//
//  APToolbarItemGroupModifier.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroupModifier<ToolBarContent: APView>: ViewModifier {
    let content: ToolBarContent
    public func body(content: Content) -> some View {
        content
            .background(
                self.content
            )
    }
    
    init(@APToolbarContentBuilder content: () -> ToolBarContent) {
        self.content = content()
    }
}

extension View {
    public func apToolbar<Content>(@APViewBuilder content: () -> Content) -> some View where Content : View {
        modifier(APToolbarItemGroupModifier(content: { APToolbarItemGroup(content: content) }))
    }
    
    public func apToolbar<Content>(@APToolbarContentBuilder content: () -> Content) -> some View where Content : APToolbarContent {
        modifier(APToolbarItemGroupModifier(content: { content() }))
    }
}

//
//  APToolbarItemGroupModifier.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroupModifier<ToolBarContent: APToolbarContent>: ViewModifier {
    let toolBarContent: ToolBarContent
    public func body(content: Content) -> some View {
        content
            .background(
                ToolBarContent._makeContent(content: toolBarContent)
            )
    }
    
    init(toolBarContent: ToolBarContent) {
        self.toolBarContent = toolBarContent
    }
}

extension View {
    public func apToolbar<Content>(@APViewBuilder content: () -> Content) -> some View where Content : View {
        modifier(APToolbarItemGroupModifier(toolBarContent: APToolbarItemGroup(content: content)))
    }
    
    public func apToolbar<Content>(@APToolbarContentBuilder content: () -> Content) -> some View where Content : APToolbarContent {
        modifier(APToolbarItemGroupModifier(toolBarContent: content()))
    }
}

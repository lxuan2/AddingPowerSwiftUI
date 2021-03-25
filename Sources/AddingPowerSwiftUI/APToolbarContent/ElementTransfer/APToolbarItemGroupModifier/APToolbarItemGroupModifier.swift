//
//  APToolbarItemGroupModifier.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroupModifier<BarContent: APToolbarContent>: ViewModifier {
    var toolBar: BarContent
    
    public func body(content: Content) -> some View {
        _VariadicView.Tree(APToolbarItemGroupContainer(content: content)) {
            toolBar
        }
    }
    
    init(toolBar: BarContent) {
        self.toolBar = toolBar
    }
}

extension View {
    public func apToolbar<Content>(@ViewBuilder content: () -> Content) -> some View where Content : View {
        modifier(APToolbarItemGroupModifier(toolBar: APToolbarItemGroup(content: content)))
    }
    
    public func apToolbar<Content>(@APToolbarContentBuilder content: () -> Content) -> some View where Content : APToolbarContent {
        modifier(APToolbarItemGroupModifier(toolBar: content()))
    }
}

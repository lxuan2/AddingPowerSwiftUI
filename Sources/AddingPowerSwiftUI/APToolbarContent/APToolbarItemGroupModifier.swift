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
            BarContent._makeContent(content: toolBar)
        }
    }
    
    init(toolBar: BarContent) {
        self.toolBar = toolBar
    }
}

struct APToolbarItemGroupContainer<Content: View>: _VariadicView_UnaryViewRoot {
    let content: Content
    @State private var id = UUID()
    
    func body(children: _VariadicView.Children) -> some View {
        var list: [(_VariadicView.Children.Element, APToolbarItemPlacement, UUID)] = []
        children.forEach {
            list.append(($0, $0[APToolbarItemPlacementTraitKey.self], id))
        }
        return content
            .transformPreference(APToolbarItemListKey.self) {
                $0.storage.append(contentsOf: list)
            }
    }
}

extension View {
    public func apToolbar<Content>(@APViewBuilder content: () -> Content) -> some View where Content : View {
        modifier(APToolbarItemGroupModifier(toolBar: APToolbarItemGroup(content: content)))
    }
    
    public func apToolbar<Content>(@APToolbarContentBuilder content: () -> Content) -> some View where Content : APToolbarContent {
        modifier(APToolbarItemGroupModifier(toolBar: content()))
    }
}

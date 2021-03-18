//
//  APToolbarItem.swift
//  
//
//

import SwiftUI

public struct APToolbarItem<Content> : APToolbarContent where Content : View {
    var placement: APToolbarItemPlacement
    var content: Content
    
    public init(placement: APToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.placement = placement
    }
    
    public static func _makeContent(content: APToolbarItem<Content>) -> some View {
        ComposeGroup(content.content)._trait(APToolbarItemPlacementTraitKey.self, content.placement)
    }
}

public struct ComposeGroup<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public init(_ content: Content) {
        self.content = content
    }

    public var body: some View {
        _VariadicView.Tree(ComposeGroupRoot()) {
            content
        }
    }

    struct ComposeGroupRoot: _VariadicView_UnaryViewRoot {
        func body(children: _VariadicView.Children) -> _VariadicView.Children {
            children
        }
    }
}

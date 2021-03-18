//
//  APToolbarItemGroup.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroup<Content> : APToolbarContent where Content : View {
    var placement: APToolbarItemPlacement
    var content: Content
    
    public init(placement: APToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content) {
        self.placement = placement
        self.content = content()
    }
    
    public static func _makeContent(content: APToolbarItemGroup<Content>) -> some View {
        content.content._trait(APToolbarItemPlacementTraitKey.self, content.placement)
    }
}

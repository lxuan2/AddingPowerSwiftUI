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
        HostView(item: content)
    }
    
    struct HostView: View {
        @StateObject private var storage = APBarButtonItemStorage(isGroup: true)
        var item: APToolbarItemGroup<Content>
        
        var body: some View {
            item
                .content
                ._trait(APBarButtonItemKey.self, APBarButtonItem(storage: storage))
                ._trait(APToolbarItemPlacementKey.self, item.placement)
        }
    }
}

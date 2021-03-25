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
        self.placement = placement
        self.content = content()
    }
    
    public var contentBody: Never {
        fatalError()
    }
    
    public var body: some View {
        HostView(item: self)
    }
    
    struct HostView: View {
        @StateObject private var storage = APBarButtonItemStorage()
        var item: APToolbarItem<Content>
        
        var body: some View {
            storage.isChanged = true
            return item
                .content
                ._trait(APBarButtonItemStorageBoxKey.self, .init(storage: storage))
                ._trait(APToolbarItemPlacementKey.self, item.placement)
        }
    }
}

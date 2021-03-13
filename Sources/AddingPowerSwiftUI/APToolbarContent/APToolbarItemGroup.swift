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
        APToolbarItemGroupHost(content)
    }
}

struct APToolbarItemGroupHost<V: View>: APView {
//    @StateObject private var storage: APBarCustomViewStorage<V>
    let content: APToolbarItemGroup<V>
    
    public var body: some View {
        EmptyView()
//            .transferView(APVariadicView_PreferenceKey.self, value: value)
    }
    
    public init(_ content: APToolbarItemGroup<V>) {
        self.content = content
    }
}

struct APToolbarItemGroupHostView<Content: View>: View {
    @StateObject private var storage = APBarButtonItemStorage()
    let item: APToolbarItem<Content>
    
    var body: some View {
        storage.updateItemStyle(item.placement.style)
        return _VariadicView.Tree(APToolbarItemHostViewRoot(storage: storage)) {
            item.content
        }
        .preference(key: APBarButtonItemPreferenceKey.self,
                    value: [APBarButtonItem(role: item.placement.role, storage: storage)])
    }
}

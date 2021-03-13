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
        APToolbarItemHostView(item: content)
    }
}

struct APToolbarItemHostView<Content: View>: View {
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

struct APToolbarItemHostViewRoot: _VariadicView_UnaryViewRoot {
    var storage: APBarButtonItemStorage
    private var hold: Bool
    
    func body(children: _VariadicView.Children) -> some View {
        storage.updateContent(children)
        return APEquatableView(id: storage.id) {
            if hold {
                EmptyView()
            } else {
                children
            }
        }
    }
    
    public init(storage: APBarButtonItemStorage) {
        self.storage = storage
        self.hold = true
    }
}

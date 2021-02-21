//
//  APToolbarItem.swift
//  
//
//

import SwiftUI

public struct APToolbarItem<Content> : APToolbarContent where Content : View {
    var placement: APToolbarItemPlacement
    var content: Content
    
    public typealias Body = Swift.Never
    public static func _makeContent(content: APToolbarItem<Content>) -> APUnaryContent<Content> {
        APUnaryContent(content.content)
    }
    
    public init(placement: APToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.placement = placement
    }
    
    public func _makeContent(content: APToolbarItem<Content>) -> some APView {
        APToolbarItemHost(content)
    }
}

struct APToolbarItemHost<V: View>: APView {
    @StateObject private var storage: APBarCustomViewStorage<V>
    let content: APToolbarItem<V>
    
    public var body: some View {
        storage.updateView(content.content)
        return APEquatableView(id: storage.id) {
            EmptyView()
        }
        .transformPreference(APBarButtonItemPreferenceKey.self) { value in
            value.append(APBarButtonItem(placement: content.placement, storage: storage))
        }
    }
    
    public init(_ content: APToolbarItem<V>) {
        self.content = content
        self._storage = .init(wrappedValue: .init(view: content.content))
    }
}

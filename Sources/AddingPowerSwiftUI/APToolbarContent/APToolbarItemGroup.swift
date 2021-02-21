//
//  APToolbarItemGroup.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroup<Content> : APToolbarContent where Content : View {
    var placement: APToolbarItemPlacement
    var content: Content
    
    public init(placement: APToolbarItemPlacement = .automatic, @APViewBuilder content: () -> Content) {
        self.placement = placement
        self.content = content()
    }
    
    public typealias Body = Swift.Never
    
    public static func _makeContent(content: APToolbarItemGroup<Content>) -> APUnaryContent<Content> {
        APUnaryContent(content.content)
    }
    
    public func _makeContent(content: APToolbarItemGroup<Content>) -> some APView {
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

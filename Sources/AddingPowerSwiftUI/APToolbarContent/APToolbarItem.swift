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
    
    public init(placement: APToolbarItemPlacement = .automatic, @APViewBuilder content: () -> Content) {
        self.content = content()
        self.placement = placement
    }
}

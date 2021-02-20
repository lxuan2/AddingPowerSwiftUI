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
}

//
//  APVariadicView_PreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public struct APVariadicView_PreferenceKey: APAnyUniqueViewPreferenceKey {
    public static var defaultValue: [APVariadicView] = []
    
    public static func reduce(value: inout [APVariadicView], nextValue: () -> [APVariadicView]) {
        value.append(contentsOf: nextValue())
    }
    
    public static func resolve(_ view: APAnyUniqueView) -> [APVariadicView] {
        [.unary(view)]
    }
    
    public static func transform(_ value: inout [APVariadicView], _ view: APAnyUniqueView) {
        value.append(.unary(view))
    }
}

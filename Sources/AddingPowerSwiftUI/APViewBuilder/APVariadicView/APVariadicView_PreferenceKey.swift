//
//  APVariadicView_PreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public struct APVariadicView_PreferenceKey: APAnySynUIViewPreferenceKey {
    public static var defaultValue: [APVariadicView] = []
    
    public static func reduce(value: inout [APVariadicView], nextValue: () -> [APVariadicView]) {
        value.append(contentsOf: nextValue())
    }
    
    public static func resolve(_ view: APAnySynView) -> [APVariadicView] {
        [.unary(view)]
    }
    
    public static func transform(_ value: inout [APVariadicView], _ view: APAnySynView) {
        value.append(.unary(view))
    }
}

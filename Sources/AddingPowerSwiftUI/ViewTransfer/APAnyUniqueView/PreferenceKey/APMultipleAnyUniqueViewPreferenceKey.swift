//
//  APMultipleAnyUniqueViewPreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/19/21.
//

import SwiftUI

public protocol APMultipleAnyUniqueViewPreferenceKey: APAnyUniqueViewPreferenceKey where Value == [APAnyUniqueView] {}

extension APMultipleAnyUniqueViewPreferenceKey {
    public static var defaultValue: Self.Value {
        []
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
    
    public static func resolve(_ view: APAnyUniqueView) -> Value {
        [view]
    }
    
    public static func transform(_ value: inout Value, _ view: APAnyUniqueView) {
        value.append(view)
    }
}

//
//  APSingleAnyUniqueViewPreferenceKey.swift
//  
//
//

import SwiftUI

public protocol APSingleAnyUniqueViewPreferenceKey: APAnyUniqueViewPreferenceKey where Value == APAnyUniqueView? {}

extension APSingleAnyUniqueViewPreferenceKey {
    public static var defaultValue: Self.Value {
        nil
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
    
    public static func resolve(_ view: APAnyUniqueView) -> Value {
        view
    }
    
    public static func transform(_ value: inout Value, _ view: APAnyUniqueView) {
        value = view
    }
}

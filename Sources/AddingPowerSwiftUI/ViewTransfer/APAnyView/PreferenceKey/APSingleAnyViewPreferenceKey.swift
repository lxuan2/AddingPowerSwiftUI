//
//  APSingleAnyViewPreferenceKey.swift
//  
//
//

import SwiftUI

public protocol APSingleAnyViewPreferenceKey: APAnyViewPreferenceKey where Value == APAnyView? {}

extension APSingleAnyViewPreferenceKey {
    public static var defaultValue: Self.Value {
        nil
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
    
    public static func resolve(_ view: APAnyView) -> Value {
        view
    }
    
    public static func transform(_ value: inout Value, _ view: APAnyView) {
        value = view
    }
}

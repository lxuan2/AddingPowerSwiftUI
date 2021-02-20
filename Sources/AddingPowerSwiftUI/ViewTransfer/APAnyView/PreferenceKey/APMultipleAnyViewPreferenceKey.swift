//
//  APMultipleAnyViewPreferenceKey.swift
//  
//
//

import SwiftUI

public protocol APMultipleAnyViewPreferenceKey: APAnyViewPreferenceKey where Value == [APAnyView] {}

extension APMultipleAnyViewPreferenceKey {
    public static var defaultValue: Self.Value {
        []
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
    
    public static func resolve(_ view: APAnyView) -> Value {
        [view]
    }
    
    public static func transform(_ value: inout Value, _ view: APAnyView) {
        value.append(view)
    }
}

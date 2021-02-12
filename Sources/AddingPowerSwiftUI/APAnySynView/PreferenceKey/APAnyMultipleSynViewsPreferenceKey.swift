//
//  APAnyMultipleSynViewsPreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public protocol APAnyMultipleSynViewsPreferenceKey: APAnySynUIViewPreferenceKey where Value == [APAnySynView] {}

extension APAnyMultipleSynViewsPreferenceKey {
    public static var defaultValue: Self.Value {
        []
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
    
    public static func resolve(_ view: APAnySynView) -> Value {
        [view]
    }
    
    public static func transform(_ value: inout Value, _ view: APAnySynView) {
        value.append(view)
    }
}

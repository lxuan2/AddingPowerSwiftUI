//
//  APNavigationLeftItemsSupplementBackButton.swift
//  
//
//

import SwiftUI

public struct APNavigationLeftItemsSupplementBackButtonPreferenceKey: PreferenceKey {
    public typealias Value = Bool
    
    public static var defaultValue: Value = false
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    public func apNavigationLeftItemsSupplementBackButton(_ isSupplement: Bool) -> some View {
        preference(key: APNavigationLeftItemsSupplementBackButtonPreferenceKey.self, value: isSupplement)
    }
}

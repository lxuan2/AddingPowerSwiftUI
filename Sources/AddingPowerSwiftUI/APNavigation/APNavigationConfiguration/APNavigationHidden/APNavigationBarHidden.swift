//
//  APNavigationBarHidden.swift
//  
//
//

import SwiftUI

extension View {
    public func apNavigationBarHidden(_ hidden: Bool) -> some View {
        preference(key: APNavigationBarHiddenPreferenceKey.self, value: hidden)
    }
}

public struct APNavigationBarHiddenPreferenceKey: PreferenceKey {
    public typealias Value = Bool
    
    public static var defaultValue: Value = false
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

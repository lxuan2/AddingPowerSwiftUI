//
//  APNavigationBarBackButtonHidden.swift
//  
//
//

import SwiftUI

extension View {
    public func apNavigationBarBackButtonHidden(_ hidesBackButton: Bool) -> some View {
        preference(key: APNavigationBarBackButtonHiddenPreferenceKey.self, value: hidesBackButton)
    }
}

public struct APNavigationBarBackButtonHiddenPreferenceKey: PreferenceKey {
    public typealias Value = Bool
    
    public static var defaultValue: Value = false
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

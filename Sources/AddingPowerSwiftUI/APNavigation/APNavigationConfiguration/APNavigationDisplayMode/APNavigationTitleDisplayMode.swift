//
//  APNavigationTitleDisplayMode.swift
//  
//
//

import SwiftUI

extension View {
    public func apNavigationBarTitleDisplayMode(_ displayMode: APNavigationBarItem.TitleDisplayMode) -> some View {
        preference(key: APNavigationTitleDisplayModePreferenceKey.self, value: displayMode)
    }
}

public struct APNavigationTitleDisplayModePreferenceKey: PreferenceKey {
    public typealias Value = APNavigationBarItem.TitleDisplayMode
    
    public static var defaultValue: Value = .automatic
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

//
//  APNavigationBackButtonDisplayMode.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

extension View {
    public func apNavigationBackButtonDisplayMode(_ displayMode: APNavigationBarItem.BackButtonDisplayMode) -> some View {
        preference(key: APNavigationBackButtonDisplayModePreferenceKey.self, value: displayMode)
    }
}

public struct APNavigationBackButtonDisplayModePreferenceKey: PreferenceKey {
    public typealias Value = APNavigationBarItem.BackButtonDisplayMode
    
    public static var defaultValue: Value = .default
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}


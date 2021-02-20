//
//  APNavigationBackButtonTitle.swift
//  
//
//

import SwiftUI

public struct APNavigationBackButtonTitlePreferenceKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    public func apNavigationBackButtonTitle(_ title: String) -> some View {
        preference(key: APNavigationTitlePreferenceKey.self, value: title)
    }
}

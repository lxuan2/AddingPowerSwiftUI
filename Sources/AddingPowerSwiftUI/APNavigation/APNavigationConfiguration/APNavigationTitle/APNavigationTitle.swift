//
//  APNavigationTitle.swift
//  
//
//

import SwiftUI

public struct APNavigationTitlePreferenceKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}



extension View {
    public func apNavigationTitle(_ title: String) -> some View {
        preference(key: APNavigationTitlePreferenceKey.self, value: title)
    }
}

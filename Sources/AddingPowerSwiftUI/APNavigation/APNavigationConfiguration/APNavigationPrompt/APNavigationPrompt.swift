//
//  APNavigationPrompt.swift
//  
//
//

import SwiftUI

extension View {
    public func apNavigationPrompt(_ prompt: String?) -> some View {
        preference(key: APNavigationPromptPreferenceKey.self, value: prompt)
    }
}

public struct APNavigationPromptPreferenceKey: PreferenceKey {
    public typealias Value = String?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

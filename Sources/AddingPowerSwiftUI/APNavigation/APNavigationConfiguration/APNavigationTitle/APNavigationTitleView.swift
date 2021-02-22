//
//  APNavigationTitleView.swift
//  
//
//

import SwiftUI

public struct APNavigationTitleViewPreferenceKey: APAnyUniqueViewPreferenceKey {
    public typealias Value = APAnyUniqueView?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
    public static func resolve(_ view: APAnyUniqueView) -> Value {
        view
    }
    
    public static func transform(_ value: inout Value, _ view: APAnyUniqueView) {
        value = view
    }
}

extension View {
    public func apNavigationTitle<V>(_ title: () -> V) -> some View where V : View {
        transferView(APNavigationTitleViewPreferenceKey.self, value: title())
    }
}

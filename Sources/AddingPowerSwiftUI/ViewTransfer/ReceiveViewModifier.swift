//
//  ReceiveViewModifier.swift
//  
//
//

import SwiftUI

public struct ReceiveViewModifier<K>: ViewModifier where K: PreferenceKey, K.Value: Equatable {
    let key: K.Type
    let value: Binding<K.Value>
    
    public init(_ key: K.Type, value: Binding<K.Value>) {
        self.key = key
        self.value = value
    }
    
    public func body(content: Content) -> some View {
        content
            .onPreferenceChange(key) { v in
                value.wrappedValue = v
            }
    }
}

extension View {
    public func onReceiveView<K: APAnyViewPreferenceKey>(_ key: K.Type, value: Binding<K.Value>) -> some View {
        modifier(ReceiveViewModifier(key, value: value))
    }
    
    public func onReceiveView<K: APAnyUniqueViewPreferenceKey>(_ key: K.Type, value: Binding<K.Value>) -> some View {
        modifier(ReceiveViewModifier(key, value: value))
    }
}

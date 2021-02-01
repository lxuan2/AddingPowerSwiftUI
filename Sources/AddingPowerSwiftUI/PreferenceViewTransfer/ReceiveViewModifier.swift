//
//  ReceiveViewModifier.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public struct ReceiveViewModifier<K: APAnyUniqueViewPreferenceKey>: ViewModifier {
    let key: K.Type
    let value: Binding<APAnyUniqueView?>
    
    public init(_ key: K.Type, value: Binding<APAnyUniqueView?>) {
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
    public func onReceiveView<K: APAnyUniqueViewPreferenceKey>(_ key: K.Type, value: Binding<APAnyUniqueView?>) -> some View {
        modifier(ReceiveViewModifier(key, value: value))
    }
}
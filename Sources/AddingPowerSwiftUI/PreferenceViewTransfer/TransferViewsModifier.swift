//
//  TransferViewModifier.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public struct TransferViewModifier<K: APAnySynUIViewPreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage = APAnySynViewStorage<V>()
    let key: K.Type
    let value: V
    
    public init(_ key: K.Type, value: V) {
        self.key = key
        self.value = value
    }
    
    public func body(content: Content) -> some View {
        storage.updateView(value)
        return APIDView(id: storage.id) {
            content
                .preference(key: key, value: K.resolve(APAnySynView(storage: storage)))
        }.equatable()
    }
}

extension View {
    public func transferView<K: APAnySynUIViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferViewModifier(key, value: value))
    }
}

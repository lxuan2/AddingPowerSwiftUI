//
//  TransferViewModifier.swift
//
//
//

import SwiftUI

public struct TransferViewModifier<K: APAnyViewPreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage: APAnyViewStorage<V>
    let key: K.Type
    let value: V
    
    public init(_ key: K.Type, value: V) {
        self.key = key
        self.value = value
        self._storage = .init(wrappedValue: .init(value))
    }
    
    public func body(content: Content) -> some View {
        storage.updateView(value)
        return APEquatableView(id: storage.id) {
            content
                .preference(key: key, value: K.resolve(APAnyView(storage: storage)))
        }
    }
}

extension View {
    public func transferView<K: APAnyViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferViewModifier(key, value: value))
    }
}

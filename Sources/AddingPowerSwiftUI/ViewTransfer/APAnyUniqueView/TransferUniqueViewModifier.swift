//
//  TransferUniqueViewModifier.swift
//  
//
//

import SwiftUI

public struct TransferUniqueViewModifier<K: APAnyUniqueViewPreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage: APAnyUniqueViewStorage<V>
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
                .preference(key: key, value: K.resolve(APAnyUniqueView(storage: storage)))
        }
    }
}

extension View {
    public func transferView<K: APAnyUniqueViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferUniqueViewModifier(key, value: value))
    }
}

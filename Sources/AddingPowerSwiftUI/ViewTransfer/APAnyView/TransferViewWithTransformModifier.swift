//
//  TransformTransferViewModifier.swift
//  Navigation
//
//

import SwiftUI

public struct TransferViewWithTransformModifier<K: APAnyViewPreferenceKey, V: View>: ViewModifier {
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
                .transformPreference(key) { v in
                    K.transform(&v, APAnyView(storage: storage))
                }
        }
    }
}

extension View {
    public func transferViewWithTransform<K: APAnyViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferViewWithTransformModifier(key, value: value))
    }
}

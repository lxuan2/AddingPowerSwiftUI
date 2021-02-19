//
//  TransferUniqueViewWithTransformModifier.swift
//  
//
//  Created by Xuan Li on 2/19/21.
//

import SwiftUI

public struct TransferUniqueViewWithTransformModifier<K: APAnyUniqueViewPreferenceKey, V: View>: ViewModifier {
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
                .transformPreference(key) { v in
                    K.transform(&v, APAnyUniqueView(storage: storage))
                }
        }
    }
}

extension View {
    public func transferViewWithTransform<K: APAnyUniqueViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferUniqueViewWithTransformModifier(key, value: value))
    }
}

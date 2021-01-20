//
//  TransferViewModifier.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public struct TransferViewModifier<K: APAnyViewPreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage = APAnyViewStorage<V>()
    let key: K.Type
    let value: V
    
    public init(_ key: K.Type, value: V) {
        self.key = key
        self.value = value
    }
    
    public func body(content: Content) -> some View {
        storage.updateView(value)
        return content
            .preference(key: key, value: APAnyView(storage: storage))
    }
}

public struct MapTransferViewModifier<K: PreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage = APAnyViewStorage<V>()
    let key: K.Type
    let value: V
    let mapToKeyValueType: (APAnyView) -> K.Value
    
    public init(_ key: K.Type, value: V, mapToKeyValueType: @escaping (APAnyView) -> K.Value) {
        self.key = key
        self.value = value
        self.mapToKeyValueType = mapToKeyValueType
    }
    
    public func body(content: Content) -> some View {
        storage.updateView(value)
        return content
            .preference(key: key, value: mapToKeyValueType(APAnyView(storage: storage)))
    }
}

extension View {
    public func transferView<K: APAnyViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransferViewModifier(key, value: value))
    }
    
    public func transferView<K: PreferenceKey, V: View>(_ key: K.Type, value: V, mapToKeyValueType: @escaping (APAnyView) -> K.Value) -> some View {
        modifier(MapTransferViewModifier(key, value: value, mapToKeyValueType: mapToKeyValueType))
    }
}

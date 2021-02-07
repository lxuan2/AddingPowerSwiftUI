//
//  TransformTransferViewModifier.swift
//  Navigation
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public struct TransformTransferViewModifier<K: APAnySynUIViewPreferenceKey, V: View>: ViewModifier {
    @StateObject private var storage = APAnySynViewStorage<V>()
    let key: K.Type
    let value: V
    
    public init(_ key: K.Type, value: V) {
        self.key = key
        self.value = value
    }
    
    public func body(content: Content) -> some View {
        storage.updateView(value)
        return content
            .transformPreference(key) { v in
                K.reduce(value: &v) {
                    K.resolve(APAnySynView(storage: storage))
                }
            }
    }
}

extension View {
    public func transferViewWithTransform<K: APAnySynUIViewPreferenceKey, V: View>(_ key: K.Type, value: V) -> some View {
        modifier(TransformTransferViewModifier(key, value: value))
    }
}

//
//  APAnyViewPreferenceKey.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public protocol APAnyUniqueViewPreferenceKey: PreferenceKey where Value == APAnyUniqueView? {}

extension APAnyUniqueViewPreferenceKey {
    public static var defaultValue: Self.Value {
        nil
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

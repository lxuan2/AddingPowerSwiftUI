//
//  APAnySingleSynViewPreferenceKey.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public protocol APAnySingleSynViewPreferenceKey: APAnySynUIViewPreferenceKey where Value == APAnySynView? {}

extension APAnySingleSynViewPreferenceKey {
    public static var defaultValue: Self.Value {
        nil
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
    
    public static func resolve(_ view: APAnySynView) -> Value {
        view
    }
    
    public static func transform(_ value: inout Value, _ view: APAnySynView) {
        value = view
    }
}

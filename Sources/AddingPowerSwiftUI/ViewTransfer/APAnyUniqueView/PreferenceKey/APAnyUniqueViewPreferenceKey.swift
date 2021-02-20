//
//  APAnyUniqueViewPreferenceKey.swift
//  
//
//

import SwiftUI

public protocol APAnyUniqueViewPreferenceKey: PreferenceKey where Value: Equatable {
    static func resolve(_ view: APAnyUniqueView) -> Value
    static func transform(_ value: inout Value, _ view: APAnyUniqueView)
}

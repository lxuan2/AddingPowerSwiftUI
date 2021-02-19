//
//  APAnyViewPreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public protocol APAnyViewPreferenceKey: PreferenceKey where Value: Equatable {
    static func resolve(_ view: APAnyView) -> Value
    static func transform(_ value: inout Value, _ view: APAnyView)
}

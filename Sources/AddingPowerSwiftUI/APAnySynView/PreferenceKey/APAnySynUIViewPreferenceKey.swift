//
//  APAnySynUIViewPreferenceKey.swift
//  
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public protocol APAnySynUIViewPreferenceKey: PreferenceKey where Value: Equatable {
    static func resolve(_ view: APAnySynView) -> Value
    static func transform(_ value: inout Value, _ view: APAnySynView)
}

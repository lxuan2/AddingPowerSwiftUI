//
//  APNavigationTitle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationTitle: Equatable {
    public var text: String
    public var view: APAnySynUIView?
}

public struct APNavigationTitlePreferenceKey: PreferenceKey {
    public typealias Value = APNavigationTitle?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

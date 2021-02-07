//
//  APNavigationTitle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationTitle: Equatable {
    public var text: String
    public var view: APAnySynView?
}

public struct APNavigationTitlePreferenceKey: APAnySynUIViewPreferenceKey {
    public typealias Value = APNavigationTitle?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
    public static func resolve(_ view: APAnySynView) -> APNavigationTitle? {
        APNavigationTitle(text: "", view: view)
    }
}

//
//  APNavigationTitle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationTitle: Equatable {
    public var text: String
    public var view: APAnyView?
}

public struct APNavigationTitlePreferenceKey: APAnyViewPreferenceKey {
    public typealias Value = APNavigationTitle?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
    public static func resolve(_ view: APAnyView) -> APNavigationTitle? {
        APNavigationTitle(text: "", view: view)
    }
    
    public static func transform(_ value: inout APNavigationTitle?, _ view: APAnyView) {
        value = APNavigationTitle(text: "", view: view)
    }
}

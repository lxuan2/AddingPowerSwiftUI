//
//  APStackNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APStackNavigationStyle: APNavigationStyle {
    public func body(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationView(content: configuration.content)
    }
    
    public init() {}
}

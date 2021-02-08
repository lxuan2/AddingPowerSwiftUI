//
//  APStackNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APStackNavigationViewStyle: APNavigationViewStyle {
    public func body(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationView(rootSource: configuration.content)
    }
    
    public init() {}
}

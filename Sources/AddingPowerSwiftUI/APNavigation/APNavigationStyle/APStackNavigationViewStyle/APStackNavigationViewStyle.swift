//
//  APStackNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APStackNavigationViewStyle: APNavigationViewStyle {
    public func makeBody(configuration: APNavigationViewStyleConfiguration) -> some View {
        APStackNavigationView(content: configuration.content)
    }
    
    public init() {}
}

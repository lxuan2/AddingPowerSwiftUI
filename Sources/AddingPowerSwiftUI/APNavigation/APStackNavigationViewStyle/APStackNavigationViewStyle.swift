//
//  APStackNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APStackNavigationViewStyle: NavigationViewStyle {
    public func _body(configuration: _NavigationViewStyleConfiguration) -> some View {
        APStackNavigationView(content: configuration.content)
    }
    
    public init() {}
}

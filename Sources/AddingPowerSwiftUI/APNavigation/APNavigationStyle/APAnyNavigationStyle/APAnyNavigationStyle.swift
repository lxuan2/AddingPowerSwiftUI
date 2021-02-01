//
//  APAnyNavigationStyle.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APAnyNavigationStyle: APNavigationStyle {
    private let makeBody: (APNavigationViewStyleConfiguration) -> APAnyUIView
    
    public func body(configuration: APNavigationViewStyleConfiguration) -> some View {
        makeBody(configuration)
    }
    
    public init<S: APNavigationStyle>(_ style: S) {
        self.makeBody = {
            APAnyUIView(style.body(configuration: $0))
        }
    }
}

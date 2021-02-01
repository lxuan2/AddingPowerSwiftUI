//
//  APNavigationStyleModifier.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationStyleModifier: ViewModifier {
    private let makeBody: (APNavigationViewStyleConfiguration) -> APAnyUIView
    
    public func body(content: Content) -> some View {
        makeBody(APNavigationViewStyleConfiguration(content))
    }
    
    public init<S: APNavigationStyle>(_ style: S) {
        self.makeBody = {
            APAnyUIView(style.body(configuration: $0))
        }
    }
}

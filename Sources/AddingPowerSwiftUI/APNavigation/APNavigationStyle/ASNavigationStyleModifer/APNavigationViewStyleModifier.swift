//
//  APNavigationViewStyleModifier.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public struct APNavigationViewStyleModifier: EnvironmentalModifier {
    public func resolve(in environment: EnvironmentValues) -> some ViewModifier {
        environment.apNavigationStyleModifier
    }
}

public struct _APNavigationViewStyleModifier: ViewModifier {
    private let makeBody: (APNavigationViewStyleConfiguration) -> APAnyRepresentable
    
    public func body(content: Content) -> some View {
        makeBody(APNavigationViewStyleConfiguration(content))
    }
    
    public init<S: APNavigationViewStyle>(_ style: S) {
        self.makeBody = {
            APAnyRepresentable(style.makeBody(configuration: $0))
        }
    }
}

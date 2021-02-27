//
//  APNavigationViewStyle.swift
//  
//
//

import SwiftUI

public protocol APNavigationViewStyle {
    associatedtype Body : View
    func makeBody(configuration: APNavigationViewStyleConfiguration) -> Body
}

public struct APNavigationViewStyleConfiguration {
    public struct Content: View {
        public typealias Body = Never
    }
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    init() {
        self.content = Content()
    }
}

extension APNavigationViewStyleConfiguration.Content: APStaticView {}

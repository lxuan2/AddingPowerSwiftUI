//
//  APNavigationStyle.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public protocol APNavigationStyle {
    associatedtype Body : View
    func body(configuration: APNavigationViewStyleConfiguration) -> Self.Body
}

public struct APNavigationViewStyleConfiguration {
    public typealias Content = _ViewModifier_Content<APNavigationStyleModifier>
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    public init(_ content: Content) {
        self.content = content
    }
}

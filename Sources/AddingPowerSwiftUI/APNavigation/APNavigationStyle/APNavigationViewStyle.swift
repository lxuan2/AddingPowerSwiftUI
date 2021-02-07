//
//  APNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public protocol APNavigationViewStyle {
    associatedtype APBody : View
    func body(configuration: APNavigationViewStyleConfiguration) -> Self.APBody
}

public struct APNavigationViewStyleConfiguration {
    public typealias Content = _ViewModifier_Content<_APNavigationViewStyleModifier>
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    public init(_ content: Content) {
        self.content = content
    }
}

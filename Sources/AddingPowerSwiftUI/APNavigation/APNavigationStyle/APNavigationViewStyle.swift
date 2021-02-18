//
//  APNavigationViewStyle.swift
//  
//
//  Created by Xuan Li on 2/1/21.
//

import SwiftUI

public protocol APNavigationViewStyle {
    associatedtype Body : View
    func makeBody(configuration: APNavigationViewStyleConfiguration) -> Self.Body
}

public struct APNavigationViewStyleConfiguration {
    public let content: APNavigationViewStyleConfiguration.Content
    
    public init(_ content: Content) {
        self.content = content
    }
}

extension APNavigationViewStyleConfiguration: APStyleConfiguration {
    public typealias Style = APAnyAPNavigationViewStyle
}

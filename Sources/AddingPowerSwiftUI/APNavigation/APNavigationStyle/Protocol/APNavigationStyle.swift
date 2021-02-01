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
    public typealias Content = ModifiedContent<APAnyUIView, _SafeAreaIgnoringLayout>
    
    public let content: APNavigationViewStyleConfiguration.Content
    
    public init<V: View>(_ v: V) {
        content = APAnyUIView(v).modifier(_SafeAreaIgnoringLayout(edges: .all))
    }
}

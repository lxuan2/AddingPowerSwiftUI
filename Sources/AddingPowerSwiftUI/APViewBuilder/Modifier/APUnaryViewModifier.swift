//
//  APUnaryViewModifier.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APUnaryViewModifier<V: View>: ViewModifier {
    private let view: V
    
    public func body(content: Content) -> some View {
        content
            .transferViewWithTransform(APViewBuilderPreferenceKey.self, value: view)
    }
    
    public init(_ v: V) {
        self.view = v
    }
}

public struct APViewBuilderPreferenceKey: APAnyMultipleSynViewsPreferenceKey {}

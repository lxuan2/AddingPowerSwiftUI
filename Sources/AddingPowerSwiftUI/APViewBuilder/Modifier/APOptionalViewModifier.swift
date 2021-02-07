//
//  APOptionalViewModifier.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

struct APOptionalViewModifier<Wrapped: ViewModifier>: ViewModifier {
    private let some: Wrapped?
    
    func body(content: Content) -> some View {
        let view: _ConditionalContent<ModifiedContent<Spacer, Wrapped>, EmptyView>
        if let _some = some {
            view = ViewBuilder.buildEither(first: Spacer().modifier(_some))
        } else {
            view = ViewBuilder.buildEither(second: EmptyView())
        }
        return content.overlay(view)
    }
    
    public init(_ some: Wrapped?) {
        self.some = some
    }
}

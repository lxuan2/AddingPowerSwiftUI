//
//  APConditionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

@frozen public struct _APConditionalContent<TrueContent, FalseContent> {
    @frozen public enum Storage {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }
    
    public let storage: _APConditionalContent<TrueContent, FalseContent>.Storage
    
    public init(storage: _APConditionalContent<TrueContent, FalseContent>.Storage) {
        self.storage = storage
    }
}

extension _APConditionalContent: ViewModifier where TrueContent: ViewModifier, FalseContent: ViewModifier {
    public func body(content: Content) -> some View {
        let view: _ConditionalContent<ModifiedContent<Spacer, TrueContent>, ModifiedContent<Spacer, FalseContent>>
        switch storage {
        case .trueContent(let tc):
            view = ViewBuilder.buildEither(first: Spacer().modifier(tc))
        case .falseContent(let fc):
            view = ViewBuilder.buildEither(second: Spacer().modifier(fc))
        }
        return content.overlay(view)
    }
}

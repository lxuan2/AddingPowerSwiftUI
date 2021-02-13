//
//  APConditionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APConditionalContent<TrueContent, FalseContent>: View where TrueContent : View, FalseContent : View {
    let content: _ConditionalContent<TrueContent, FalseContent>
    let pathAttribute: APPath.Attribute
    @StateObject private var viewRoot = APVariadicView_MultiViewHost()
    @EnvironmentObject private var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                content
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.updates(viewRoot: $0, in: viewRoot, atrribute: pathAttribute)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @usableFromInline
    init(first: TrueContent) {
        self.content = ViewBuilder.buildEither(first: first)
        pathAttribute = .truePath
    }
    
    @usableFromInline
    init(second: FalseContent) {
        self.content = ViewBuilder.buildEither(second: second)
        pathAttribute = .falsePath
    }
}

public struct APConditionalContentModifier: ViewModifier {
    let transContent: [APVariadicView]
    public func body(content: Content) -> some View {
        content
            .preference(key: APVariadicView_PreferenceKey.self, value: transContent)
    }
}

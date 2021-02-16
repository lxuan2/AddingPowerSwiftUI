//
//  APConditionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APConditionalContent<TrueContent, FalseContent>: View where TrueContent : View, FalseContent : View {
    let content: _ConditionalContent<TrueContent, FalseContent>
    let env: APPathEnvironment
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot()
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                content
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.viewRootReplace(viewRoot, $0, env)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @usableFromInline
    init(first: TrueContent) {
        self.content = ViewBuilder.buildEither(first: first)
        env = .conditional(true)
    }
    
    @usableFromInline
    init(second: FalseContent) {
        self.content = ViewBuilder.buildEither(second: second)
        env = .conditional(false)
    }
}

public struct APConditionalContentModifier: ViewModifier {
    let transContent: [APVariadicView]
    public func body(content: Content) -> some View {
        content
            .preference(key: APVariadicView_PreferenceKey.self, value: transContent)
    }
}

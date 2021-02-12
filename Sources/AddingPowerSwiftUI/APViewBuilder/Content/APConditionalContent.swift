//
//  APConditionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APConditionalContent<TrueContent, FalseContent>: View where TrueContent : View, FalseContent : View {
    let content: _ConditionalContent<TrueContent, FalseContent>
    @StateObject private var root = APVariadicView_MultiViewHost()
    @EnvironmentObject var coordinator: APVariadicView.Coordinator
    
    public var body: some View {
        content
            .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                coordinator.updateViews($0, with: root, operation: .conditional)
            }
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(root)])
    }
    
    @usableFromInline
    init(first: TrueContent) {
        self.content = ViewBuilder.buildEither(first: first)
    }
    
    @usableFromInline
    init(second: FalseContent) {
        self.content = ViewBuilder.buildEither(second: second)
    }
}

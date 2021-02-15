//
//  APOptionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APOptionalContent<Wrapped: View>: View {
    let some: Wrapped?
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot()
    @EnvironmentObject var coordinator: APVariadicView_RootCoordinatorHolder
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                some
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.body.onReplace(in: viewRoot, with: $0, env: .conditional(some != nil))
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @usableFromInline
    init(_ some: Wrapped?) {
        self.some = some
    }
}

//
//  APOptionalContent.swift
//  Navigation
//
//

import SwiftUI

public struct APOptionalContent<Wrapped: View>: APView {
    let some: Wrapped?
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot()
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APEquatableView(id: viewRoot.id) {EmptyView()}
            .overlay(
                some
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.viewRootReplace(viewRoot, $0, .conditional(some != nil))
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @usableFromInline
    init(_ some: Wrapped?) {
        self.some = some
    }
}

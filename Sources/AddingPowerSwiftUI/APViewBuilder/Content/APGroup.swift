//
//  APGroup.swift
//  
//
//

import SwiftUI

public struct APGroup<Content: View>: APView {
    @usableFromInline
    var content: Content
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot(env: .group)
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APEquatableView(id: viewRoot.id) {EmptyView()}
            .overlay(
                content
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.viewRootReplace(viewRoot, $0, .group)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @inlinable public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @inlinable public init(content: Content) {
        self.content = content
    }
}

//
//  APGroup.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

public struct APGroup<Content: View>: APView {
    @usableFromInline
    var content: Content
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot(env: .group)
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                content
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.viewRootChange(viewRoot, $0)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @inlinable public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

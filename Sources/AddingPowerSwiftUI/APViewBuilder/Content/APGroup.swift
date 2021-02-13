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
    @StateObject private var viewRoot = APVariadicView_Root()
    @EnvironmentObject private var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                content
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.replace(viewRoot: $0, in: viewRoot, atrribute: .any)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @inlinable public init(@APViewBuilder content: () -> Content) {
        self.content = content()
    }
}

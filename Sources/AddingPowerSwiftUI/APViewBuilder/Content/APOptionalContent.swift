//
//  APOptionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APOptionalContent<Wrapped: View>: View {
    let some: Wrapped?
    @StateObject private var viewRoot = APVariadicView_Root()
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
    
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                some
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.replace(viewRoot: $0, in: viewRoot, atrribute: some == nil ? .falsePath : .truePath)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
    
    @usableFromInline
    init(_ some: Wrapped?) {
        self.some = some
    }
}

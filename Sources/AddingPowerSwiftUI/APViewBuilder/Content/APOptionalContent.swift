//
//  APOptionalContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APOptionalContent<Wrapped: View>: View {
    let some: Wrapped?
    @StateObject private var root = APVariadicView_MultiViewHost()
    @EnvironmentObject var coordinator: APVariadicView.Coordinator
    
    public var body: some View {
        some
            .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                coordinator.updateViews($0, with: root, operation: .conditional)
            }
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(root)])
    }
    
    @usableFromInline
    init(_ some: Wrapped?) {
        self.some = some
    }
}

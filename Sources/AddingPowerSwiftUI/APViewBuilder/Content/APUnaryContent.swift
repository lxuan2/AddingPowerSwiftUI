//
//  APUnaryContent.swift
//  Navigation
//
//

import SwiftUI

public struct APUnaryContent<V: View>: APView {
    let value: V
    
    public var body: some View {
        EmptyView()
            .transferView(APVariadicView_PreferenceKey.self, value: value)
    }
    
    public init(_ v: V) {
        self.value = v
    }
}

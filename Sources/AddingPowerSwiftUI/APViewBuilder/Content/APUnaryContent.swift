//
//  APUnaryContent.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public struct APUnaryContent<V: View>: View {
    let view: V
    
    public var body: some View {
        EmptyView()
            .transferView(APVariadicView_PreferenceKey.self, value: view)
    }
    
    public init(_ v: V) {
        self.view = v
    }
}

//
//  APToolbarContent.swift
//  
//
//

import SwiftUI

public protocol APToolbarContent {
    associatedtype Body : APToolbarContent
    @APToolbarContentBuilder var body: Self.Body { get }
}

extension APToolbarContent where Body == Never {
    public var body: Never {
        fatalError()
    }
}

extension Never: APToolbarContent {}

struct APToolbarUnaryContent<V: APToolbarContent>: APView {
//    @StateObject private var storage: APBarCustomViewStorage<V>
    let value: V
    
    public var body: some View {
        EmptyView()
//            .transferView(APVariadicView_PreferenceKey.self, value: value)
    }
    
    public init(_ v: V) {
        self.value = v
    }
}

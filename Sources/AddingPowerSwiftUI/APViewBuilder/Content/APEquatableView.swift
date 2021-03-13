//
//  APEquatableView.swift
//  Navigation
//
//

import SwiftUI

struct APEquatableView<ID : Hashable, Content: View>: View {
    let id: ID
    let content: Content
    
    public init(id: ID, @ViewBuilder content: () -> Content) {
        self.id = id
        self.content = content()
    }
    
    public var body: some View {
        _APEquatableView(id: id, content: content)
            .equatable()
    }
}

struct _APEquatableView<ID : Hashable, Content: View>: View, Equatable {
    let id: ID
    let content: Content
    
    public init(id: ID, content: Content) {
        self.id = id
        self.content = content
    }
    
    public var body: some View {
        content
    }
    
    static func == (lhs: _APEquatableView<ID, Content>, rhs: _APEquatableView<ID, Content>) -> Bool {
        lhs.id == rhs.id
    }
}

//
//  APIDView.swift
//  Navigation
//
//  Created by Xuan Li on 2/7/21.
//

import SwiftUI

struct APIDView<ID : Hashable, Content: View>: View, Equatable {
    let id: ID
    let content: Content
    
    public init(id: ID, content: () -> Content) {
        self.id = id
        self.content = content()
    }
    
    public var body: some View {
        content
    }
    
    static func == (lhs: APIDView<ID, Content>, rhs: APIDView<ID, Content>) -> Bool {
        lhs.id == rhs.id
    }
}

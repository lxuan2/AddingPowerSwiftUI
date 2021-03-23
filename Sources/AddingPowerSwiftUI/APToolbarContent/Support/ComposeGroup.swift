//
//  ComposeGroup.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

public struct ComposeGroup<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public init(_ content: Content) {
        self.content = content
    }
    
    public var body: some View {
        _VariadicView.Tree(ComposeGroupRoot()) {
            content
        }
    }
    
    struct ComposeGroupRoot: _VariadicView_UnaryViewRoot {
        func body(children: _VariadicView.Children) -> _VariadicView.Children {
            children
        }
    }
}

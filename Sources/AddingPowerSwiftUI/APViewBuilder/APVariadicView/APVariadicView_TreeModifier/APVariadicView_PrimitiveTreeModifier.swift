//
//  APVariadicView_PrimitiveTreeModifier.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

public struct APVariadicView_PrimitiveTreeModifier<APVariadicView_Tree: View>: ViewModifier {
    @ObservedObject private var coordinator: APVariadicView.CoordinatorBase
    let tree: APVariadicView_Tree
    
    public func body(content: Content) -> some View {
        content
            .background(
                tree
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.initRoot(with: $0)
                    }
                    .environmentObject(coordinator)
            )
    }
    
    public init(tree: APVariadicView_Tree, coordinator: ObservedObject<APVariadicView.CoordinatorBase>) {
        self.tree = tree
        self._coordinator = coordinator
    }
}

extension View {
    public func treeView<APVariadicView_Tree: View>(_ tree: APVariadicView_Tree, coordinator: ObservedObject<APVariadicView.CoordinatorBase>) -> some View {
        modifier(APVariadicView_PrimitiveTreeModifier(tree: tree, coordinator: coordinator))
    }
}

//
//  APVariadicView_TreeModifier.swift
//  
//
//  Created by Xuan Li on 2/12/21.
//

import SwiftUI

public struct APVariadicView_TreeModifier<APVariadicView_Tree: View>: ViewModifier {
    @StateObject private var coordinator: APVariadicView.Coordinator
    let tree: APVariadicView_Tree
    let delegate: APVariadicView_Delegate
    
    public func body(content: Content) -> some View {
        coordinator.delegate = delegate
        return content
            .background(
                tree
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.initRoot(with: $0)
                    }
                    .environmentObject(coordinator)
            )
    }
    
    public init(tree: APVariadicView_Tree, delegate: APVariadicView_Delegate) {
        self.tree = tree
        self.delegate = delegate
        self._coordinator = .init(wrappedValue: APVariadicView.Coordinator(delegate: delegate))
    }
}

extension View {
    public func treeView<APVariadicView_Tree: View>(_ tree: APVariadicView_Tree, delegate: APVariadicView_Delegate) -> some View {
        modifier(APVariadicView_TreeModifier(tree: tree, delegate: delegate))
    }
}

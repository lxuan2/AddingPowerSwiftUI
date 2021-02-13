//
//  APVariadicView_TreeModifier.swift
//  
//
//  Created by Xuan Li on 2/12/21.
//

import SwiftUI

public struct APVariadicView_TreeModifier<APVariadicView_Tree: View>: ViewModifier {
    @StateObject private var coordinator: APVariadicView.CoordinatorBase
    let tree: APVariadicView_Tree
    let updateDelegate: (APVariadicView.CoordinatorBase) -> ()
    
    public func body(content: Content) -> some View {
        updateDelegate(coordinator)
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
        self.updateDelegate = {
            let c = $0 as! APVariadicView.Coordinator
            c.delegate = delegate
        }
        self._coordinator = .init(wrappedValue: APVariadicView.Coordinator(delegate: delegate))
    }
    
    public init(tree: APVariadicView_Tree, delegate: APVariadicView_PrimitiveDelegate) {
        self.tree = tree
        self.updateDelegate = {
            let c = $0 as! APVariadicView.PrimitiveCoordinator
            c.delegate = delegate
        }
        self._coordinator = .init(wrappedValue: APVariadicView.PrimitiveCoordinator(delegate: delegate))
    }
}

extension View {
    public func treeView<APVariadicView_Tree: View>(_ tree: APVariadicView_Tree, delegate: APVariadicView_Delegate) -> some View {
        modifier(APVariadicView_TreeModifier(tree: tree, delegate: delegate))
    }
    
    public func treeView<APVariadicView_Tree: View>(_ tree: APVariadicView_Tree, delegate: APVariadicView_PrimitiveDelegate) -> some View {
        modifier(APVariadicView_TreeModifier(tree: tree, delegate: delegate))
    }
}

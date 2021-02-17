//
//  APVariadicView_Tree.swift
//  
//
//  Created by Xuan Li on 2/15/21.
//

import SwiftUI

extension APVariadicView {
    public struct Tree<Root: APVariadicView_RootProtocol, Content: View, Coordinator: APVariadicView_CoordinatorProtocol>: View where Root.Configuration == Coordinator.Configuration {
        public var root: Root
        public var content: Content
        @StateObject private var coordinator: Coordinator
        
        public var body: some View {
            root
                .makeBody(configuration: coordinator.toConfiguration())
                .background(
                    content
                        .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                            coordinator.rootChange($0)
                        }
                        .environmentObject(coordinator as CoordinatorBase)
                )
        }
    }
}

extension APVariadicView.Tree where Root: APVariadicView_Root, Coordinator == APVariadicView.Coordinator {
    public init(root: Root, content: Content) {
        self.root = root
        self.content = content
        self._coordinator = .init(wrappedValue: APVariadicView.Coordinator())
    }
    
    public init(_ root: Root, @APViewBuilder content: () -> Content) {
        self.init(root: root, content: content())
    }
}

extension APVariadicView.Tree where Root: APVariadicView_PrimitiveRoot, Coordinator == APVariadicView.PrimitiveCoordinator {
    public init(root: Root, content: Content) {
        self.root = root
        self.content = content
        self._coordinator = .init(wrappedValue: APVariadicView.PrimitiveCoordinator())
    }
    
    public init(_ root: Root, @APViewBuilder content: () -> Content) {
        self.init(root: root, content: content())
    }
}

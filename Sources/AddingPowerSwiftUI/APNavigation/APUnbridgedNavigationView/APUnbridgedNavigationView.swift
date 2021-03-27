//
//  APUnbridgedNavigationView.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

// MARK: - APUnbridgedNavigationView

public struct APUnbridgedNavigationView<Content: View>: View {
    @StateObject private var nvc: APUnbridgedNavigationController<Content>
    var content: Content
    var areLargeTitlesEnabled: Bool
    
    public var body: some View {
        nvc.navigationBar.prefersLargeTitles = areLargeTitlesEnabled
        nvc.root = content
        return APUnbridgedNavigationRepresentable(nvc: nvc)
            .environment(\.apNavigationController, APNavigationControllerBox(controller: nvc))
            .edgesIgnoringSafeArea(.all)
    }
    
    init(content: Content, areLargeTitlesEnabled: Bool = false) {
        self.content = content
        self.areLargeTitlesEnabled = areLargeTitlesEnabled
        self._nvc = .init(wrappedValue: APUnbridgedNavigationController(rootView: content))
    }
}

// MARK: - APUnbridgedNavigationRepresentable

struct APUnbridgedNavigationRepresentable<Content: View>: UIViewControllerRepresentable {
    unowned var nvc: APUnbridgedNavigationController<Content>
    
    public func makeUIViewController(context: Context) -> APUnbridgedNavigationController<Content> {
        return nvc
    }
    
    public func updateUIViewController(_ uiViewController: APUnbridgedNavigationController<Content>, context: Context) {}
}

// MARK: - APUnbridgedNavigationController

public class APUnbridgedNavigationController<Content: View>: UINavigationController, ObservableObject {
    public var root: Content {
        get {
            _root.wrappedRootView.content
        }
        set {
            _root.wrappedRootView = ModifiedContent(content: newValue, modifier: _SafeAreaIgnoringLayout(edges: [.horizontal, .bottom]))
        }
    }
    public unowned var _root: APUnbridgedNavigation_ChildController<ModifiedContent<Content, _SafeAreaIgnoringLayout>>
    
    public init(rootView: Content) {
        let r = APUnbridgedNavigation_ChildController(rootView: ModifiedContent(content: rootView, modifier: _SafeAreaIgnoringLayout(edges: .all)))
        self._root = r
        super.init(rootViewController: r)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

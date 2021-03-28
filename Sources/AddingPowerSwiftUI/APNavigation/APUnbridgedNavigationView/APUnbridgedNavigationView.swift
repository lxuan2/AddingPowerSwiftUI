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
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            viewController.modalPresentationStyle = .overFullScreen
            viewController.view.alpha = 0
            viewController.view.isUserInteractionEnabled = false
            present(viewController, animated: false) {
                viewController.dismiss(animated: false) {
                    viewController.modalPresentationStyle = .automatic
                    viewController.view.alpha = 1
                    viewController.view.isUserInteractionEnabled = true
                    super.pushViewController(viewController, animated: false)
                    super.popViewController(animated: false)
                    DispatchQueue.main.async {
                        super.pushViewController(viewController, animated: true)
                    }
                }
            }
        } else {
            super.pushViewController(viewController, animated: false)
        }
    }
}

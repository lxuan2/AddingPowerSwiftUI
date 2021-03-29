//
//  APUnbridgedNavigationView.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

// MARK: - APUnbridgedNavigationView

public struct APUnbridgedNavigationView<Content: View>: View {
    @StateObject private var nvc = APUnbridgedNavigationController()
    var content: Content
    
    public var body: some View {
        APUnbridgedNavigationRepresentable(nvc: nvc, content: content)
            .environment(\.apNVC, APUnbridgedNavigationControllerBox(controller: nvc))
            .edgesIgnoringSafeArea(.all)
    }
    
    public init(content: Content) {
        self.content = content
    }
}

// MARK: - APUnbridgedNavigationRepresentable

struct APUnbridgedNavigationRepresentable<Content: View>: UIViewControllerRepresentable {
    unowned var nvc: APUnbridgedNavigationController
    var content: Content
    
    func makeCoordinator() -> Coordinator {
        Coordinator(content: content, nvc: nvc)
    }
    
    public func makeUIViewController(context: Context) -> APUnbridgedNavigationController {
        nvc.viewControllers.append(context.coordinator.rootViewController)
        return nvc
    }
    
    public func updateUIViewController(_ uiViewController: APUnbridgedNavigationController, context: Context) {
        context.coordinator.rootViewController.rootView = content
    }
    
    class Coordinator {
        var rootViewController: APNavigationBridgedController<Content>
        
        init(content: Content, nvc: APUnbridgedNavigationController) {
            rootViewController = .init(rootView: content, navigationController: nvc, animationEnabledOnInit: false)
        }
    }
}

// MARK: - APUnbridgedNavigationController

public final class APUnbridgedNavigationController: UINavigationController, ObservableObject {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            view.addSubview(viewController.view)
            view.sendSubviewToBack(viewController.view)
            view.layoutIfNeeded()
            super.pushViewController(viewController, animated: true)
        } else {
            super.pushViewController(viewController, animated: false)
        }
    }
}

// MARK: - APUnbridgedNavigationControllerBox

public struct APUnbridgedNavigationControllerBox {
    public weak var controller: APUnbridgedNavigationController?
}

// MARK: - APUnbridgedNavigationControllerKey

public struct APUnbridgedNavigationControllerKey: EnvironmentKey {
    public static let defaultValue = APUnbridgedNavigationControllerBox()
}

extension EnvironmentValues {
    public var apNVC: APUnbridgedNavigationControllerBox  {
        get {
            return self[APUnbridgedNavigationControllerKey.self]
        }
        set {
            self[APUnbridgedNavigationControllerKey.self] = newValue
        }
    }
}

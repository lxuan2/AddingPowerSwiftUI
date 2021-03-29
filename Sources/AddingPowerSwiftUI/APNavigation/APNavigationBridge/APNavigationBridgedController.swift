//
//  APNavigationBridgedController.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

// MARK: - APNavigationBridgedController

public final class APNavigationBridgedController<Content: View>: UIViewController {
    
    public init(rootView: Content, navigationController: UINavigationController, animationEnabledOnInit: Bool = true) {
        bridge = .init(nvc: navigationController, vc: nil, animationEnabledOnInit: animationEnabledOnInit)
        hostController = HostingController(rootView: rootView.modifier(APNavigationBridgeModifier(configuration: bridge)))
        super.init(nibName: nil, bundle: nil)
        bridge.setViewController(self)
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hostController)
        view.addSubview(hostController.view)
        hostController.view.constrainEdges(to: view)
        hostController.didMove(toParent: self)
    }
    
    public var rootView: Content {
        set {
            self.hostController.rootView = newValue.modifier(APNavigationBridgeModifier(configuration: bridge))
        }
        get {
            self.hostController.rootView.content
        }
    }
    
    private var bridge: APNavigationBridge
    private var hostController: HostingController<ModifiedContent<Content, APNavigationBridgeModifier>>
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bridge.viewWillAppear()
    }
    
    final class HostingController<C: View>: UIHostingController<C> {
        
        override var navigationController: UINavigationController? {
            nil
        }
    }
}

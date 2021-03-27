//
//  APUnbridgedNavigation_ChildController.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

public class APUnbridgedNavigation_ChildController<Root: View>: UIHostingController<ModifiedContent<Root, APUnbridgedNavigation_ChildModifier>> {

    public init(rootView: Root) {
        super.init(rootView: rootView.modifier(.init(configuration: configuration)))
        configuration.setViewController(self)
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var wrappedRootView: Root {
        set {
            self.rootView = newValue.modifier(.init(configuration: configuration))
        }
        get {
            self.rootView.content
        }
    }
    
    private var configuration = APUnbridgedNavigationConfiguration(viewController: nil)
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuration.viewWillAppear()
    }
}

//
//  APUnbridgedNavigation_ChildController.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

public class APUnbridgedNavigation_ChildController<InternelContent: View>: UIHostingController<APUnbridgedNavigation_Child<InternelContent>> {

    public init(rootView: InternelContent) {
        super.init(rootView: APUnbridgedNavigation_Child(content: rootView))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.rootView = APUnbridgedNavigation_Child(content: rootView, navigationItem: self.navigationItem, vc: self)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var wrappedRootView: InternelContent {
        set {
            self.rootView = APUnbridgedNavigation_Child(content: newValue, navigationItem: self.navigationItem, vc: self)
        }
        
        get {
            self.rootView.content
        }
    }
    
    private var isNavigationBarHidden = false
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(toolbarItems?.isEmpty ?? true, animated: animated)
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? false
    }
}

//
//  APNavigationPageController.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public class APNavigationPageController<Content: View>: UIHostingController<APNavigationPageView<Content>> {

    public init(rootView: Content) {
        super.init(rootView: APNavigationPageView(content: rootView, navigationItem: nil))
        self.rootView = APNavigationPageView(content: rootView, navigationItem: self.navigationItem)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var wrappedRootView: Content {
        set {
            self.rootView = APNavigationPageView(content: newValue, navigationItem: self.navigationItem)
        }
        
        get {
            self.rootView.content
        }
    }
}

//
//  APNavigationPageController.swift
//  
//
//

import SwiftUI

public class APNavigationPageController<InternelContent: View>: UIHostingController<APNavigationPageView<InternelContent>> {

    public init(rootView: InternelContent) {
        super.init(rootView: APNavigationPageView(content: rootView))
        self.rootView = APNavigationPageView(content: rootView, navigationItem: self.navigationItem, vc: self)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var wrappedRootView: InternelContent {
        set {
            self.rootView = APNavigationPageView(content: newValue, navigationItem: self.navigationItem, vc: self)
        }
        
        get {
            self.rootView.content
        }
    }
}

public struct APNavigationPageView<Content: View>: View {
    var content: Content
    weak var navigationItem: UINavigationItem?
    weak var vc: UIViewController?
    
    public var body: some View {
        content.modifier(APNavigationPageConfigurationModifier(navigationItem: navigationItem, vc: vc))
    }
}

//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView<Content: View>: View {
    @StateObject var nvc = APNavigationController(rootViewController: UIViewController())
    let content: Content
    
    public var body: some View {
        APNavigationHostingView(nvc: nvc)
            .environment(\.apNavigationController, APNavigationControllerHolder(vc: nvc))
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                nvc.setNavigationBarHidden(hidden, animated: true)
            }
            .edgesIgnoringSafeArea(.all)
            .treeView(content, delegate: Delegate(nvc: nvc))
    }
    
    public init(content: Content) {
        self.content = content
    }
    
    public init(@APViewBuilder content: () -> Content){
        self.content = content()
    }
}

extension APStackNavigationView {
    private struct Delegate: APVariadicView_PrimitiveDelegate {
        unowned var nvc: APNavigationController
        
        func subRoot(subRoot: APVariadicView_MultiViewHost, didUpdate newViewRoot: [APVariadicView], in root: APVariadicView_MultiViewHost) {
            if let loc = nvc.rootLocation {
                if loc.contains(subRoot.location!) {
                    nvc.viewControllers[0] = UIViewController()
                    nvc.rootLocation = nil
                }
            } else {
                initial(root)
            }
        }
        
        func initial(_ root: APVariadicView_MultiViewHost) {
            if let (location, view) = root.getLocationAndView(at: 0) {
                nvc.viewControllers[0] = APNavigationPageController(rootView: view.edgesIgnoringSafeArea(.all))
                nvc.rootLocation = location
            }
        }
        
        init(nvc: APNavigationController) {
            self.nvc = nvc
        }
    }
}

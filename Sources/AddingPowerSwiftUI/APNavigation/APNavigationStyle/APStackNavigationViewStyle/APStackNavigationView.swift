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
    private struct Delegate: APVariadicView_Delegate {
        weak var nvc: UINavigationController?
        
        func operate(at index: Int, remove amount: Int, add newViews: [APAnySynView]) {
            if index == 0 , let first = newViews.first {
                nvc?.viewControllers[0] = APNavigationPageController(rootView: first.edgesIgnoringSafeArea(.all))
            }
        }
        
        init(nvc: UINavigationController?) {
            self.nvc = nvc
        }
    }
}

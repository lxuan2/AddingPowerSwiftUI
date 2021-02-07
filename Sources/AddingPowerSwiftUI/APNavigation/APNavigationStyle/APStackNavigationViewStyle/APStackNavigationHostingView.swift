//
//  APStackNavigationHostingView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APStackNavigationHostingView: UIViewControllerRepresentable, Equatable {
    let root: APAnySynView?
    @Binding var navigationController: APNavigationControllerHolder
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        let rvc = APNavigationPageController(rootView: root.edgesIgnoringSafeArea(.all))
        let nvc = APNavigationController(rootViewController: rvc)
        DispatchQueue.main.async {
            navigationController = APNavigationControllerHolder(vc: nvc)
        }
        return nvc
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        let rvc = APNavigationPageController(rootView: root.edgesIgnoringSafeArea(.all))
        uiViewController.viewControllers[0] = rvc
    }
    
    public static func == (lhs: APStackNavigationHostingView, rhs: APStackNavigationHostingView) -> Bool {
        lhs.root?.id == rhs.root?.id
    }
}

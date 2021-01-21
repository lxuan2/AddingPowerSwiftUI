//
//  APNavigationHostingView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationHostingView<Master: View, Detail: View>: UIViewControllerRepresentable {
    let master: Master
    let detail: Detail?
    @Binding var navigationController: APNavigationControllerHolder
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        let rvc = APNavigationPageController(rootView: master)
        let nvc = APNavigationController(rootViewController: rvc)
        DispatchQueue.main.async {
            navigationController = APNavigationControllerHolder(vc: nvc)
        }
        return nvc
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        let rvc = uiViewController.viewControllers[0] as! APNavigationPageController<Master>
        rvc.wrappedRootView = master
    }
}

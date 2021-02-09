//
//  APNavigationHostingView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationHostingView: UIViewControllerRepresentable {
    unowned var nvc: UIViewController
    
    public func makeUIViewController(context: Context) -> UIViewController {
        return nvc
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

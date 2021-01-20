//
//  APAnyView.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public struct APAnyView: UIViewControllerRepresentable, Equatable {
    public var storage: APAnyViewStorageBase
    
    public func makeUIViewController(context: Context) -> UIViewController {
        storage.makeUIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

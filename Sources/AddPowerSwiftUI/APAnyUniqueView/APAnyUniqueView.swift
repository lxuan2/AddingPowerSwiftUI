//
//  APAnyView.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

/// Can be passed through without worry, but only can be used as View in one place
/// Usage: transfer one view to another place for rendering
public struct APAnyUniqueView: UIViewControllerRepresentable, Equatable {
    public var storage: APAnyUniqueViewStorageBase
    
    public func makeUIViewController(context: Context) -> UIViewController {
        storage.makeUIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

//
//  APAnySynUIView.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

/// An `APAnySynUIView` is a type erasing view used for transfering one view to
/// antoher place for rendering. Note: each storage maintains one uiviewcontroller at
/// a time. In other words, `makeUIViewController(context:)` can only be
/// called once.
///
/// The type information is hidden in underlining storage. The view update is handled
/// by the location which creates the storage. The view make is handled by the exact
/// location which rendered it. This is a very effiecent method to make and update
/// the view when transfering one view to another place through envrionment or
/// preference path.
public struct APAnySynUIView: UIViewControllerRepresentable, Equatable {
    public var storage: APAnySynUIViewStorageBase
    
    public func makeUIViewController(context: Context) -> UIViewController {
        storage.makeUIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    @inlinable public func makeUIViewController() -> UIViewController {
        storage.makeUIViewController()
    }
    
    @inlinable public func makeUIView() -> UIView {
        storage.makeUIViewController().view
    }
}

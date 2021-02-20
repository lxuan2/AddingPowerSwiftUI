//
//  APAnyView.swift
//
//
//

import SwiftUI

/// An `APAnyView` is a type erasing view used for transfering one view to
/// antoher place for rendering. Note: each storage maintains one uiviewcontroller at
/// a time. In other words, `makeUIViewController(context:)` can only be
/// called once.
///
/// The type information is hidden in underlining storage. The view update is handled
/// by the location which creates the storage. The view make is handled by the exact
/// location which rendered it. This is a very effiecent method to make and update
/// the view when transfering one view to another place through envrionment or
/// preference path.
public struct APAnyView: UIViewControllerRepresentable, Equatable, Identifiable {
    public var id: UUID {
        storage.id
    }
    
    public var storage: APAnyViewStorageBase
    
    public init(storage: APAnyViewStorageBase) {
        self.storage = storage
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        storage.makeUIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    @inlinable public func makeUIViewController() -> UIViewController {
        storage.makeUIViewController()
    }
}

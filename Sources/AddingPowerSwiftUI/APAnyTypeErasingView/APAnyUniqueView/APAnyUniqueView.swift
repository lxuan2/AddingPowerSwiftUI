//
//  APAnyUniqueView.swift
//  
//
//  Created by Xuan Li on 2/19/21.
//

import SwiftUI

public struct APAnyUniqueView: UIViewControllerRepresentable, Equatable, Identifiable {
    
    public var storage: APAnyUniqueViewStorageBase
    
    @inlinable public init(storage: APAnyUniqueViewStorageBase) {
        self.storage = storage
    }
    
    @inlinable public func makeUIViewController(context: Context) -> UIViewController {
        storage.getUIViewController()
    }
    
    @inlinable public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    @inlinable public func getUIViewController() -> UIViewController {
        storage.getUIViewController()
    }
    
    @inlinable public func getUIView() -> UIView {
        storage.getUIViewController().view
    }
    
    @inlinable public var isInUse: Bool {
        storage.isInUse
    }
    
    @inlinable public var id: UUID {
        storage.id
    }
}

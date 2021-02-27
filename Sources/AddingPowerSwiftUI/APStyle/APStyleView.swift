//
//  APStyleView.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

public struct APStyleView<Key: APStyleKey> {
    var configuration: Key.Configuration
    
    public init(_ key: Key.Type, _ configuration: Key.Configuration) {
        self.configuration = configuration
    }
}

extension APStyleView: UIViewControllerRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        if let vc = context.environment[Key.self]?.makeViewController(configuration: configuration) {
            return vc
        }
        let vc = UIHostingController(rootView: Key.makeDefault(configuration: configuration))
        context.coordinator.defaultStorage = vc
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let storage = context.coordinator.defaultStorage {
            storage.rootView = Key.makeDefault(configuration: configuration)
        } else {
            context.environment[Key.self]?.updateConfiguration(configuration: configuration, uiviewController: uiViewController)
        }
    }
    
    public class Coordinator {
        weak var defaultStorage: UIHostingController<Key.Body>?
    }
}

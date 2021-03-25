//
//  APStyleView.swift
//  
//
//  Created by Xuan Li on 3/24/21.
//

import SwiftUI

// MARK: - APStyleView

public struct APStyleView<Key: APStyleKey>: View {
    var configuration: Key.Configuration
    
    public init(key: Key.Type = Key.self, configuration: Key.Configuration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        _APStyleView<Key>(configuration: configuration)
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - _APStyleView

public struct _APStyleView<Key: APStyleKey> {
    var configuration: Key.Configuration
    
    public init(key: Key.Type = Key.self, configuration: Key.Configuration) {
        self.configuration = configuration
    }
}

extension _APStyleView: UIViewControllerRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        if let styleCoordinator = context.environment[Key.self] {
            context.coordinator.styleCoordinator = styleCoordinator
            return styleCoordinator.makeViewController(configuration: configuration)
        }
        let vc = UIHostingController(rootView: Key.makeDefault(configuration: configuration))
        context.coordinator.defaultStorage = vc
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let storage = context.coordinator.defaultStorage {
            storage.rootView = Key.makeDefault(configuration: configuration)
        } else {
            context.coordinator.styleCoordinator
                .updateConfiguration(configuration: configuration, uiviewController: uiViewController)
        }
    }
    
    public class Coordinator {
        weak var defaultStorage: UIHostingController<Key.DefaultBody>?
        var styleCoordinator: APStyleCoordinator<Key.Configuration>!
    }
}

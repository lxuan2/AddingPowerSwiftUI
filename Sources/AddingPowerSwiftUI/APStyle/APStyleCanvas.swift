//
//  APStyleCanvas.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStyleCanvas

public protocol APStyleCanvas: EnvironmentKey where Value == APStyleCanvasCoordinator<Configuration>? {
    associatedtype Configuration
    associatedtype DefaultBody: View
    static func makeDefault(configuration: Configuration) -> DefaultBody
}

extension APStyleCanvas {
    public static var defaultValue: Value { nil }
    public static func makeBody(configuration: Configuration) -> _APStyleView<Self> {
        _APStyleView(configuration: configuration)
    }
}

// MARK: - APStyleCanvasCoordinator

public class APStyleCanvasCoordinator<Configuration> {
    func makeViewController(configuration: Configuration) -> UIViewController {
        fatalError("APStyleCanvasCoordinator: base class is not implemented")
    }
    
    func updateConfiguration(configuration: Configuration, uiviewController: UIViewController) {
        fatalError("APStyleCanvasCoordinator: base class is not implemented")
    }
}

// MARK: - _APStyleView

public struct _APStyleView<Key: APStyleCanvas> {
    var configuration: Key.Configuration
    
    public init(configuration: Key.Configuration) {
        self.configuration = configuration
    }
}

extension _APStyleView: UIViewControllerRepresentable {
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
        weak var defaultStorage: UIHostingController<Key.DefaultBody>?
    }
}

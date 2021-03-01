//
//  APCanvas.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APCanvas

protocol APCanvas: UIViewControllerRepresentable, EnvironmentKey where Value == APCanvasCoordinator? {
    associatedtype DefaultBody: View
    static func makeDefault() -> DefaultBody
}

extension APCanvas {
    public static var defaultValue: APCanvasCoordinator? { nil }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewController {
        context.environment[Self]?.makeViewController() ?? UIHostingController(rootView: Self.makeDefault())
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Self>) {}
}

extension APCanvas where DefaultBody == EmptyView {
    static func makeDefault() -> EmptyView {
        EmptyView()
    }
}

// MARK: - APCanvasCoordinator

public class APCanvasCoordinator {
    public func makeViewController() -> UIViewController {
        fatalError("StaticView_Coordinator: base class is not implmented")
    }
}

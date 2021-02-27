//
//  APStaticView.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStaticView

protocol APStaticView: UIViewControllerRepresentable, EnvironmentKey where Value == APStaticView_Coordinator? {
    associatedtype StaticBody: View
    static func makeDefault() -> StaticBody
}

extension APStaticView {
    public static var defaultValue: APStaticView_Coordinator? { nil }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewController {
        context.environment[Self]?.makeViewController() ?? UIHostingController(rootView: Self.makeDefault())
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<Self>) {}
}

extension APStaticView where StaticBody == EmptyView {
    static func makeDefault() -> EmptyView {
        EmptyView()
    }
}

// MARK: - APStaticView_Coordinator

public class APStaticView_Coordinator: ObservableObject {
    public func makeViewController() -> UIViewController {
        fatalError("StaticView_Coordinator: base class is not implmented")
    }
}

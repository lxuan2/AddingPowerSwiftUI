//
//  APAnyRepresentable.swift
//  
//
//

import SwiftUI

public struct APAnyRepresentable: UIViewControllerRepresentable {
    private let _makeUIViewController: () -> UIViewController
    private let _updateUIViewController: (UIViewController) -> ()
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        _makeUIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        _updateUIViewController(uiViewController)
    }
    
    public init<V: View>(_ v: V) {
        _makeUIViewController = {
            UIHostingController(rootView: v)
        }
        _updateUIViewController = {
            let c = $0 as! UIHostingController<V>
            c.rootView = v
        }
    }
}

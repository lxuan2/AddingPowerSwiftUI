//
//  APAnyViewStorage.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnyUniqueViewStorage<V: View> : APAnyUniqueViewStorageBase {
    private var _view: V?
    private weak var _uiViewController: UIHostingController<V>?
    
    public init(_ view: V? = nil) {
        _view = view
    }
    
    public override func makeUIViewController() -> UIViewController {
        if _uiViewController != nil {
            fatalError("IOS6AnyViewStorage: UIViewController has already been initialized!")
        }
        let vc = UIHostingController(rootView: _view!)
        vc.view.isOpaque = false
        vc.view.backgroundColor = .clear
        _uiViewController = vc
        return vc
    }
    
    public func updateView(_ v: V) {
        _view = v
        _uiViewController?.rootView = v
    }
}

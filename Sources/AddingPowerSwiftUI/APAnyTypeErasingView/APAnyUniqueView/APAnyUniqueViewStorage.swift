//
//  APAnyUniqueViewStorage.swift
//  
//
//

import SwiftUI

public class APAnyUniqueViewStorage<V: View> : APAnyUniqueViewStorageBase {
    private var view: V
    private weak var subscriber: UIHostingController<V>?
    
    public init(_ v: V) {
        view = v
        subscriber = nil
    }
    
    public override func getUIViewController() -> UIViewController {
        if let s = subscriber {
            return s
        }
        let vc = UIHostingController(rootView: view)
        vc.view.isOpaque = false
        vc.view.backgroundColor = .clear
        subscriber = vc
        return vc
    }
    
    public func updateView(_ v: V) {
        view = v
        subscriber?.rootView = v
    }
    
    public override var isInUse: Bool {
        subscriber != nil
    }
}

//
//  APAnyUniqueViewStorage.swift
//  
//
//

import SwiftUI

public class APAnyUniqueViewStorage<V: View> : APAnyUniqueViewStorageBase {
    private var view: V
    private weak var subscriber: UIHostingView<V>?
    
    public init(_ v: V) {
        view = v
        subscriber = nil
    }
    
    public override func getView() -> ClassView {
        if let s = subscriber {
            return s
        }
        let v = UIHostingView(rootView: view)
        subscriber = v
        return v
    }
    
    public func updateView(_ v: V) {
        view = v
        subscriber?.rootView = v
    }
    
    public override var isInUse: Bool {
        subscriber != nil
    }
}

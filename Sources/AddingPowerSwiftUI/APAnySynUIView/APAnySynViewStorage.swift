//
//  APAnySynViewStorage.swift
//  IOS6Navigation
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnySynViewStorage<V: View> : APAnySynViewStorageBase {
    private var view: V?
    private var subscribers: [Weak<UIHostingController<V>>]
    
    public init(_ v: V? = nil) {
        view = v
        subscribers = []
    }
    
    public override func makeUIViewController() -> UIViewController {
        let vc = UIHostingController(rootView: view!)
        vc.view.isOpaque = false
        vc.view.backgroundColor = .clear
        subscribers.append(Weak(body: vc))
        return vc
    }
    
    public func updateView(_ v: V) {
        view = v
        subscribers.removeAll(where: { $0.body == nil })
        subscribers.forEach {
            $0.body?.rootView = v
        }
    }
    
    private struct Weak<T: AnyObject> {
        weak var body: T?
    }
}

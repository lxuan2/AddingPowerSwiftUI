//
//  APAnyViewStorage.swift
//  IOS6Navigation
//
//

import SwiftUI

public class APAnyViewStorage<V: View> : APAnyViewStorageBase {
    private var view: V?
    private var subscribers: [Weak<UIHostingController<V>>]
    
    public init(_ v: V) {
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

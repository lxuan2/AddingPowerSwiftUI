//
//  APAnyViewStorage.swift
//  IOS6Navigation
//
//

import SwiftUI

public class APAnyViewStorage<V: View> : APAnyViewStorageBase {
    private var view: V?
    private var subscribers: [Weak<UIHostingView<V>>]
    
    public init(_ v: V) {
        view = v
        subscribers = []
    }
    
    public override func makeView() -> ClassView {
        let v = UIHostingView(rootView: view!)
        subscribers.append(Weak(body: v))
        return v
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

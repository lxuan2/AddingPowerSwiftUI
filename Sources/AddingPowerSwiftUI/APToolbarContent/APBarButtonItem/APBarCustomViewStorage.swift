//
//  APBarCustomViewStorage.swift
//  
//
//

import SwiftUI

public class APBarCustomViewStorage<V: View>: APBarButtonItemStorageBase {
    internal init(view: V) {
        self.view = view
        self.subscriber = nil
    }
    
    private var view: V
    private weak var subscriber: APUIBarButtonItem<V>?
    
    public override func getUIBarButtonItem() -> UIBarButtonItem {
        if let item = subscriber {
            return item
        }
        let item = APUIBarButtonItem<V>()
        subscriber = item
        item.host = UIHostingController(rootView: view)
        return item
    }
    
    public func updateView(_ v: V) {
        view = v
        subscriber?.host.rootView = v
    }
}

public class APUIBarButtonItem<V: View>: UIBarButtonItem {
    var host: UIHostingController<V>!
}

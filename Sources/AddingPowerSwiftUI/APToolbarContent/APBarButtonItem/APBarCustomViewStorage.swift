//
//  APBarCustomViewStorage.swift
//  
//
//

import SwiftUI

public class APBarCustomViewStorage<V: View>: APBarButtonItemStorageBase {
    internal init(view: V, subscriber: UIHostingController<V>? = nil) {
        self.view = view
        self.subscriber = subscriber
    }
    
    private var view: V
    private weak var subscriber: UIHostingController<V>?
    
    
}

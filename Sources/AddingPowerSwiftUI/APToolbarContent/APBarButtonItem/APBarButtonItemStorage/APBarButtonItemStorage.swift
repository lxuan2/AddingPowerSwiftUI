//
//  APBarButtonItemStorage.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

class APBarButtonItemStorage: APBarButtonItemStorageBase {
    var isChanged: Bool = false
    var storage = _APBarButtonItemStorage()
    
    override init() {}
    
    override func getBarButtonItem(key: AnyHashable) -> UIBarButtonItem {
        storage.getBarButtonItem()
    }
    
    override func getView(key: AnyHashable) -> UIView {
        storage.getView()
    }
    
    override func getItemGroup(_ elements: [_VariadicView.Children.Element]) -> [APBarButtonItem] {
        let element = elements[0]
        if isChanged {
            storage.updateItem(element: element)
            isChanged = false
        }
        return [.init(storage: self, key: element.id)]
    }
}


class _APBarButtonItemStorage {
    var rootView: _VariadicView.Children.Element?
    weak var subscriber: APHostingBarButtonItem?
    weak var viewSubscriber: UIHostingView<_VariadicView.Children.Element>?
    
    init(rootView: _VariadicView.Children.Element? = nil) {
        self.rootView = rootView
    }
    
    func getBarButtonItem() -> UIBarButtonItem {
        if let s = subscriber {
            return s
        }
        let s = APHostingBarButtonItem(rootView: rootView!)
        subscriber = s
        return s
    }
    
    func getView() -> UIView {
        if let s = viewSubscriber {
            return s
        }
        let s = UIHostingView(rootView: rootView!)
        viewSubscriber = s
        return s
    }
    
    func updateItem(element: _VariadicView.Children.Element) {
        if let s = subscriber {
            s.rootView = element
        }
        if let s = viewSubscriber {
            s.rootView = element
        }
        rootView = element
    }
    
    func isThisOne(_ id: AnyHashable) -> Bool {
        rootView!.id == id
    }
}

//
//  APBarButtonItemGroupStorage.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

class APBarButtonItemGroupStorage: APBarButtonItemStorageBase {
    var isChanged: Bool = false
    var storages: [_APBarButtonItemStorage] = []
    
    override init() {}
    
    override func getBarButtonItem(key: AnyHashable) -> UIBarButtonItem {
        if let s = storages.first(where: { $0.isThisOne(key) }) {
            return s.getBarButtonItem()
        }
        return UIBarButtonItem()
    }
    
    override func getView(key: AnyHashable) -> UIView {
        if let s = storages.first(where: { $0.isThisOne(key) }) {
            return s.getView()
        }
        return UIView()
    }
    
    override func getItemGroup(_ elements: [_VariadicView.Children.Element]) -> [APBarButtonItem] {
        if isChanged {
            var r: [APBarButtonItem] = []
            var newStorage: [_APBarButtonItemStorage] = []
            elements.forEach { element in
                let key = element.id
                if let s = storages.first(where: { $0.isThisOne(key) }) {
                    s.updateItem(element: element)
                    newStorage.append(s)
                } else {
                    let s = _APBarButtonItemStorage(rootView: element)
                    newStorage.append(s)
                }
                r.append(APBarButtonItem(storage: self, key: key))
            }
            storages = newStorage
            isChanged = false
            return r
        }
        return storages.map({ APBarButtonItem(storage: self, key: $0.rootView!.id) })
    }
}

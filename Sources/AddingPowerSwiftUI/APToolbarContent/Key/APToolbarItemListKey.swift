//
//  APToolbarItemListKey.swift
//  
//
//  Created by Xuan Li on 3/17/21.
//

import SwiftUI

struct APToolbarItemListKey: PreferenceKey {
    static var defaultValue = APToolbarItemList(storage: [])
    
    static func reduce(value: inout APToolbarItemList, nextValue: () -> APToolbarItemList) {
        value.storage.append(contentsOf: nextValue().storage)
    }
}

struct APToolbarItemList: Equatable {
    var storage: [(_VariadicView.Children.Element, APToolbarItemPlacement, UUID)]
    
    static func == (lhs: APToolbarItemList, rhs: APToolbarItemList) -> Bool {
        lhs.storage.elementsEqual(rhs.storage) { (l, r) in
            l.0.id == r.0.id && l.1 == r.1 && l.2 == r.2
        }
    }
}

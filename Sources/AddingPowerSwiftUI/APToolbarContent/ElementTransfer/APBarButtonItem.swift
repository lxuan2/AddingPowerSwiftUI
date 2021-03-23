//
//  APBarButtonItem.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

struct APBarButtonItem: Equatable {
    var storage: APBarButtonItemStorage
    
    func getBarButtonItem() -> UIBarButtonItem {
        storage.getBarButtonItem()
    }
    
    func getView() -> UIView {
        storage.getView()
    }
    
    static func == (lhs: APBarButtonItem, rhs: APBarButtonItem) -> Bool {
        lhs.storage === rhs.storage
    }
}

struct APBarButtonItemKey: _ViewTraitKey {
    static var defaultValue: APBarButtonItem? = nil
}


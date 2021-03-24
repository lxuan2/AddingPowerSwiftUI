//
//  APBarButtonItem.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

struct APBarButtonItem: Equatable {
    var storage: APBarButtonItemStorageBase
    var key: AnyHashable
    
    func getBarButtonItem() -> UIBarButtonItem {
        storage.getBarButtonItem(key: key)
    }
    
    func getView() -> UIView {
        storage.getView(key: key)
    }
}

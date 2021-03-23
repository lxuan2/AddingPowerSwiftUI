//
//  APBarButtonItemPayload.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

struct APBarButtonItemPayload: Equatable {
    var topLeftBarButtonItems: [APBarButtonItem] = []
    var topRightBarButtonItems: [APBarButtonItem] = []
    var bottomBarItems: [APBarButtonItem] = []
    var backBarButtonItem: APBarButtonItem?
    var title: APBarButtonItem?
}

struct APToolBarItemPayloadKey: PreferenceKey {
    static var defaultValue = APBarButtonItemPayload()
    
    static func reduce(value: inout APBarButtonItemPayload, nextValue: () -> APBarButtonItemPayload) {
        let next = nextValue()
        value.topLeftBarButtonItems.append(contentsOf: next.topLeftBarButtonItems)
        value.topRightBarButtonItems.append(contentsOf: next.topRightBarButtonItems)
        value.bottomBarItems.append(contentsOf: next.bottomBarItems)
        if let b = next.backBarButtonItem {
            value.backBarButtonItem = b
        }
        if let t = next.title {
            value.title = t
        }
    }
}



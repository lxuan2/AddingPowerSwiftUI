//
//  APBarButtonItemStorageBox.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

struct APBarButtonItemStorageBox {
    var storage: APBarButtonItemStorageBase
}

struct APBarButtonItemStorageBoxKey: _ViewTraitKey {
    static var defaultValue: APBarButtonItemStorageBox? = nil
}

//
//  APBarButtonItem.swift
//  
//
//

import SwiftUI

public struct APBarButtonItem: Equatable, Identifiable {
    
    public private(set) var storage: APBarButtonItemStorageBase
    public private(set) var placement: APToolbarItemPlacement
    
    public init(placement: APToolbarItemPlacement, storage: APBarButtonItemStorageBase) {
        self.storage = storage
        self.placement = placement
    }
    
    @inlinable var item: UIBarButtonItem {
        storage.getUIBarButtonItem()
    }
    
    @inlinable public var id: UUID {
        storage.id
    }
}

struct APBarButtonItemPreferenceKey: PreferenceKey {
    static var defaultValue: [APBarButtonItem] = []
    static func reduce(value: inout [APBarButtonItem], nextValue: () -> [APBarButtonItem]) {
        value.append(contentsOf: nextValue())
    }
}

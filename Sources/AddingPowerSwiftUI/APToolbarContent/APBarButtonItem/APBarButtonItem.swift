//
//  APBarButtonItem.swift
//  
//
//

import SwiftUI

public struct APBarButtonItem: Equatable, Identifiable {
    public private(set) var storage: APBarButtonItemStorage
    public private(set) var role: APToolbarItemPlacement.Role
    
    public init(role: APToolbarItemPlacement.Role, storage: APBarButtonItemStorage) {
        self.storage = storage
        self.role = role
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

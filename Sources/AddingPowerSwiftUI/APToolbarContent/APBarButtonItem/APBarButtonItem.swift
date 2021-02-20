//
//  APBarButtonItem.swift
//  
//
//

import SwiftUI

public struct APBarButtonItem: Equatable, Identifiable {
    
    public var storage: APBarButtonItemStorageBase
    
    @inlinable public init(storage: APBarButtonItemStorageBase) {
        self.storage = storage
    }
    
    @inlinable public func getUIBarButtonItem() -> UIBarButtonItem {
        storage.getUIBarButtonItem()
    }
    
    @inlinable public var id: UUID {
        storage.id
    }
}

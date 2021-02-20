//
//  APBarButtonItemStorageBase.swift
//  
//
//

import SwiftUI

public class APBarButtonItemStorageBase: Equatable, ObservableObject {
    public let id = UUID()
    
    public static func == (lhs: APBarButtonItemStorageBase, rhs: APBarButtonItemStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public func getUIBarButtonItem() -> UIBarButtonItem {
        fatalError()
    }
}

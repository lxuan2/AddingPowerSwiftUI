//
//  APAnyUniqueViewStorageBase.swift
//  
//
//

import SwiftUI

public class APAnyUniqueViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnyUniqueViewStorageBase, rhs: APAnyUniqueViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func getView() -> ClassView {
        fatalError("APAnyUniqueViewStorageBase: getView is not implemented!")
    }
    
    public var isInUse: Bool {
        fatalError("APAnyUniqueViewStorageBase: isInUse is not implemented!")
    }
}


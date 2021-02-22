//
//  APAnyViewStorageBase.swift
//  
//
//

import SwiftUI

public class APAnyViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnyViewStorageBase, rhs: APAnyViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func makeView() -> ClassView {
        fatalError("APAnyViewStorageBase: makeView is not implemented!")
    }
}

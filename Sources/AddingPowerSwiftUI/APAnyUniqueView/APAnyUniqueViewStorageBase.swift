//
//  APAnyUniqueViewStorageBase.swift
//  
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnyUniqueViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnyUniqueViewStorageBase, rhs: APAnyUniqueViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func makeUIViewController() -> UIViewController {
        fatalError("APAnyUniqueViewStorageBase: makeUIViewController is not implemented!")
    }
}
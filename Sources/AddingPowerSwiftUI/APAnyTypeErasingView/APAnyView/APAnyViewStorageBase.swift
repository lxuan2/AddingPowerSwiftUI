//
//  APAnyViewStorageBase.swift
//  
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnyViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnyViewStorageBase, rhs: APAnyViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func makeUIViewController() -> UIViewController {
        fatalError("APAnyViewStorageBase: makeUIViewController is not implemented!")
    }
}

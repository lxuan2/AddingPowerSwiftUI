//
//  APAnySynUIViewStorageBase.swift
//  
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnySynUIViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnySynUIViewStorageBase, rhs: APAnySynUIViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func makeUIViewController() -> UIViewController {
        fatalError("APAnySynUIViewStorageBase: makeUIViewController is not implemented!")
    }
}

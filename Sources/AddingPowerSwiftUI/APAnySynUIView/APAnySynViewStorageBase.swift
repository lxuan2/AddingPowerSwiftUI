//
//  APAnySynViewStorageBase.swift
//  
//
//  Created by Xuan Li on 1/20/21.
//

import SwiftUI

public class APAnySynViewStorageBase: Identifiable, Equatable, ObservableObject {
    public static func == (lhs: APAnySynViewStorageBase, rhs: APAnySynViewStorageBase) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID()
    
    public func makeUIViewController() -> UIViewController {
        fatalError("APAnySynViewStorageBase: makeUIViewController is not implemented!")
    }
}

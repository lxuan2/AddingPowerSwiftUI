//
//  APVariadicView_MultiViewHost.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public class APVariadicView_MultiViewHost: ObservableObject, Identifiable, Equatable {
    public var body: [APVariadicView] = []
    public var id: UUID = UUID()
    public var location: [Int]?
    public var isInited = false
    
    public init() {}
    
    public static func == (lhs: APVariadicView_MultiViewHost, rhs: APVariadicView_MultiViewHost) -> Bool {
        lhs.id == rhs.id
    }
}

//
//  APVariadicView.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI
import Combine

public enum APVariadicView: Equatable {
    case unary(APVariadicView_UnaryViewRoot)
    case multi(APVariadicView_MultiViewRoot)
}

public typealias APVariadicView_UnaryViewRoot = APAnyUniqueView

//
//  APVariadicView.swift
//  
//
//

import SwiftUI
import Combine

public enum APVariadicView: Equatable {
    case unary(APVariadicView_UnaryViewRoot)
    case multi(APVariadicView_MultiViewRoot)
}

public typealias APVariadicView_UnaryViewRoot = APAnyUniqueView

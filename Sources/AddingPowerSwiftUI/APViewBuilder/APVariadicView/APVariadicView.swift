//
//  APVariadicView.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public enum APVariadicView: Equatable {
    public typealias UnaryViewRoot = APAnySynView
    public typealias MultiViewRoot = APVariadicView_Root
    case unary(UnaryViewRoot)
    case multi(MultiViewRoot)
}

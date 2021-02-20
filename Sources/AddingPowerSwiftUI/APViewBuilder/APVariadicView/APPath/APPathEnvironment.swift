//
//  SwiftUIView.swift
//  
//
//

import SwiftUI

public enum APPathEnvironment: Equatable {
    case none
    case conditional(Bool)
    case identifiable
    case group
}

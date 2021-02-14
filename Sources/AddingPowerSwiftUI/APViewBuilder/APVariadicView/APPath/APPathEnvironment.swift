//
//  SwiftUIView.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

public enum APPathEnvironment: Equatable {
    case none
    case conditional(Bool)
    case identifiable
    case group
}

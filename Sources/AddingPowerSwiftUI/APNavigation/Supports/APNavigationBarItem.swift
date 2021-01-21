//
//  APNavigationBarItem.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationBarItem {
    
    public enum TitleDisplayMode: Equatable, Hashable {
        
        case automatic
        
        case inline
        
        case large
    }
    
    public enum BackButtonDisplayMode: Equatable, Hashable {
        
        case `default`
        
        case generic
        
        case minimal
    }
    
    var backButtonTitle: String?
    
    var backBarButtonItem: UUID?
    
    var leftItemsSupplementBackButton: Bool = false
    
    var leftBarButtonItems: UUID?
    
    var rightBarButtonItems: UUID?

}

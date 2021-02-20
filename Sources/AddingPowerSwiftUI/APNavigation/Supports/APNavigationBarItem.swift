//
//  APNavigationBarItem.swift
//  
//
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
    
    var backBarButtonItem: UUID?
    
    var leftBarButtonItems: UUID?
    
    var rightBarButtonItems: UUID?

}

//
//  APToolbarItemPlacement.swift
//  
//
//

import SwiftUI

public struct APToolbarItemPlacement: Equatable {
    public static let automatic = APToolbarItemPlacement(role: .automatic, style: .plain)
    
    @available(watchOS, unavailable)
    public static let principal = APToolbarItemPlacement(role: .principal, style: .plain)
    
    @available(watchOS, unavailable)
    public static let navigation = APToolbarItemPlacement(role: .navigation, style: .plain)
    
    public static let primaryAction = APToolbarItemPlacement(role: .primaryAction, style: .done)
    
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let status = APToolbarItemPlacement(role: .status, style: .plain)
    
    public static let confirmationAction = APToolbarItemPlacement(role: .confirmationAction, style: .done)
    
    public static let cancellationAction = APToolbarItemPlacement(role: .cancellationAction, style: .plain)
    
    public static let destructiveAction = APToolbarItemPlacement(role: .destructiveAction, style: .plain)
    
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarLeading = APToolbarItemPlacement(role: .navigationBarLeading, style: .plain)
    
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarTrailing = APToolbarItemPlacement(role: .navigationBarTrailing, style: .plain)
    
    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let bottomBar = APToolbarItemPlacement(role: .bottomBar, style: .plain)
    
    public enum Role {
        case automatic
        case principal
        case status
        case primaryAction
        case confirmationAction
        case cancellationAction
        case destructiveAction
        case navigation
        case navigationBarLeading
        case navigationBarTrailing
        case bottomBar
    }
    
    public enum Style {
        case plain
        case done
        
        func asUIElement() -> UIBarButtonItem.Style {
            switch self {
            case .plain:
                return .plain
            case .done:
                return .done
            }
        }
    }
    
    public var role: Role
    public var style: Style
}

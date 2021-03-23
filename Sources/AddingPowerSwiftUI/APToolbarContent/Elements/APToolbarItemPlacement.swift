//
//  APToolbarItemPlacement.swift
//  
//
//

import SwiftUI

public struct APToolbarItemPlacement: Equatable {
    public static let automatic = APToolbarItemPlacement(role: .automatic)
    
    @available(watchOS, unavailable)
    public static let principal = APToolbarItemPlacement(role: .principal)
    
    @available(watchOS, unavailable)
    public static let navigation = APToolbarItemPlacement(role: .navigation)
    
    public static let primaryAction = APToolbarItemPlacement(role: .primaryAction)
    
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let status = APToolbarItemPlacement(role: .status)
    
    public static let confirmationAction = APToolbarItemPlacement(role: .confirmationAction)
    
    public static let cancellationAction = APToolbarItemPlacement(role: .cancellationAction)
    
    public static let destructiveAction = APToolbarItemPlacement(role: .destructiveAction)
    
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarLeading = APToolbarItemPlacement(role: .navigationBarLeading)
    
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarTrailing = APToolbarItemPlacement(role: .navigationBarTrailing)
    
    @available(OSX, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarBackButton = APToolbarItemPlacement(role: .navigationBarBackButton)
    
    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let bottomBar = APToolbarItemPlacement(role: .bottomBar)
    
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
        case navigationBarBackButton
        case bottomBar
    }
    
    var role: Role
}

struct APToolbarItemPlacementKey: _ViewTraitKey {
    static var defaultValue: APToolbarItemPlacement = .automatic
}

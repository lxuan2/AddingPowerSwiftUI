//
//  APNavigationControllerHolder.swift
//  
//
//

import SwiftUI

public struct APNavigationControllerBox {
    public weak var controller: UINavigationController?
}

public struct APNavigationControllerHolderEnvironmentKey: EnvironmentKey {
    public static let defaultValue = APNavigationControllerBox()
}

extension EnvironmentValues {
    public var apNavigationController: APNavigationControllerBox  {
        get {
            return self[APNavigationControllerHolderEnvironmentKey.self]
        }
        set {
            self[APNavigationControllerHolderEnvironmentKey.self] = newValue
        }
    }
}

//
//  APNavigationControllerHolder.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationControllerHolder {
    weak var vc: UINavigationController?
}

public struct APNavigationControllerHolderEnvironmentKey: EnvironmentKey {
    public static let defaultValue = APNavigationControllerHolder()
}

extension EnvironmentValues {
    public var apNavigationController: APNavigationControllerHolder  {
        get {
            return self[APNavigationControllerHolderEnvironmentKey.self]
        }
        set {
            self[APNavigationControllerHolderEnvironmentKey.self] = newValue
        }
    }
}

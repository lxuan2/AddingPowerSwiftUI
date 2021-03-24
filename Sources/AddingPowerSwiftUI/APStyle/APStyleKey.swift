//
//  APStyleKey.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStyleKey

public protocol APStyleKey: EnvironmentKey where Value == APStyleCoordinator<Configuration>? {
    associatedtype Configuration
    associatedtype DefaultBody: View
    static func makeDefault(configuration: Configuration) -> DefaultBody
}

extension APStyleKey {
    public static var defaultValue: Value { nil }
}

// MARK: - APStyleCoordinator

public class APStyleCoordinator<Configuration> {
    func makeViewController(configuration: Configuration) -> UIViewController {
        fatalError("APStyleCoordinator: base class is not implemented")
    }
    
    func updateConfiguration(configuration: Configuration, uiviewController: UIViewController) {
        fatalError("APStyleCoordinator: base class is not implemented")
    }
}

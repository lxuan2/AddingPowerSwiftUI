//
//  APStyleKey.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

public protocol APStyleKey: EnvironmentKey where Value == APStyleCoordinatorBase<Configuration>? {
    associatedtype Configuration
    associatedtype Body: View
    static func makeDefault(configuration: Configuration) -> Body
}

extension APStyleKey {
    public static var defaultValue: Value { nil }
}

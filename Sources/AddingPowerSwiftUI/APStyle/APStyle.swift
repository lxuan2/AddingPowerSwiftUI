//
//  APStyle.swift
//  
//
//

import SwiftUI

public protocol APStyle where Self == Configuration.Style  {
    associatedtype Body: View
    associatedtype Configuration: APStyleConfiguration
    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public protocol APStyleConfiguration {
    associatedtype Style: APStyle
    typealias Content = _ViewModifier_Content<APStyleContent<Style>>
    var content: Content { get }
}

//
//  APVariadicView_Root.swift
//  
//
//

import SwiftUI
import Combine

public protocol APVariadicView_RootProtocol {
    associatedtype Configuration
    associatedtype Body: View
    func makeBody(configuration: Configuration) -> Body
}

public protocol APVariadicView_Root: APVariadicView_RootProtocol
where Configuration == APVariadicViewConfiguration {}

public protocol APVariadicView_PrimitiveRoot: APVariadicView_RootProtocol
where Configuration == APVariadicViewPrimitiveConfiguration {}

public struct APVariadicViewConfiguration {
    public let onInit: AnyPublisher<[APAnyUniqueView], Never>
    public let onReplace: AnyPublisher<([APAnyUniqueView], Range<Int>, [APAnyUniqueView]), Never>
    public let onModification: AnyPublisher<([APAnyUniqueView], Range<Int>, [APAnyUniqueView]), Never>
}

public struct APVariadicViewPrimitiveConfiguration {
    public unowned let root: APVariadicView_MultiViewRoot
    public let rootInit: AnyPublisher<Void, Never>
    public let viewRootReplace: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>
    public let viewRootModification: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>
}

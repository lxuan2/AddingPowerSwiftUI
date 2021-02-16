//
//  APVariadicView_Root.swift
//  
//
//  Created by Xuan Li on 2/15/21.
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

public protocol APVariadicView_RawRoot: APVariadicView_RootProtocol
where Configuration == APVariadicViewRawConfiguration {}

public struct APVariadicViewConfiguration {
    public let onInit: AnyPublisher<[APAnySynView], Never>
    public let onChange: AnyPublisher<([APAnySynView], Range<Int>, [APAnySynView]), Never>
    public let onReplace: AnyPublisher<([APAnySynView], Range<Int>, [APAnySynView]), Never>
    public let onModification: AnyPublisher<([APAnySynView], Range<Int>, [APAnySynView]), Never>
}

public struct APVariadicViewPrimitiveConfiguration {
    public unowned let root: APVariadicView_MultiViewRoot
    public let rootInit: AnyPublisher<Void, Never>
    public let viewRootChange: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView]), Never>
    public let viewRootReplace: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>
    public let viewRootModification: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>
}

public struct APVariadicViewRawConfiguration {
    public unowned let root: APVariadicView_MultiViewRoot
    public let rootChange: AnyPublisher<[APVariadicView], Never>
    public let viewRootChange: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView]), Never>
    public let viewRootReplace: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>
    public let viewRootModification: AnyPublisher<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>
}

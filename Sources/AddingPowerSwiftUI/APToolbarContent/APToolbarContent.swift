//
//  APToolbarContent.swift
//  
//
//

import SwiftUI

public protocol APToolbarContent: View {
    associatedtype ContentBody : APToolbarContent
    @APToolbarContentBuilder var contentBody: ContentBody { get }
}

extension APToolbarContent where ContentBody == Body {
    public var body: ContentBody {
        contentBody
    }
}

extension Never: APToolbarContent {
    public typealias ContentBody = Never
    public var contentBody: Never {
        fatalError()
    }
}

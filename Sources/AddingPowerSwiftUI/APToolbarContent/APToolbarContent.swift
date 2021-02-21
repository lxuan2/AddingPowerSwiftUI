//
//  APToolbarContent.swift
//  
//
//

import SwiftUI

public protocol APToolbarContent {
    associatedtype Body : APToolbarContent
    @APToolbarContentBuilder var body: Body { get }
    associatedtype _Body : APView
    static func _makeContent(content: Self) -> _Body
}

extension APToolbarContent where Body == Never {
    public var body: Never {
        fatalError()
    }
}

extension Never: APToolbarContent, APView {
    public static func _makeContent(content: Never) -> Never {}
}

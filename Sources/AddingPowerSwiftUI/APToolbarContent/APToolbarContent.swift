//
//  APToolbarContent.swift
//  
//
//

import SwiftUI

public protocol APToolbarContent {
    associatedtype Body : APToolbarContent
    @APToolbarContentBuilder var body: Body { get }
    associatedtype _Body : View
    static func _makeContent(content: Self) -> _Body
}

extension APToolbarContent where Body == Never {
    public var body: Never {
        fatalError()
    }
}

extension APToolbarContent where _Body == Body._Body {
    public static func _makeContent(content: Self) -> _Body {
        Body._makeContent(content: content.body)
    }
}

extension Never: APToolbarContent, APView {
    public static func _makeContent(content: Never) -> Never {}
}

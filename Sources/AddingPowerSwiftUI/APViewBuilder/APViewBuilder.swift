//
//  APViewBuilder.swift
//  Navigation
//
//

import SwiftUI

public protocol APView: View {}

@_functionBuilder
public struct APViewBuilder {
    
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }
    
    public static func buildExpression<Content>(_ content: Content) -> some APView where Content : View {
        APUnaryContent(content)
    }
    
    public static func buildExpression(_ content: Image) -> some APView {
        APUnaryContent(content.border(Color.red))
    }
    
    public static func buildExpression<Content>(_ content: Content) -> some APView where Content : APView {
        content
    }
    
    public static func buildBlock<Content>(_ content: Content) -> some APView where Content : APView {
        content
    }
}

extension APViewBuilder {
    
    public static func buildIf<Content>(_ content: Content?) -> some APView where Content : APView {
        APOptionalContent(content)
    }
    
    @_alwaysEmitIntoClient
    public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> APConditionalContent<TrueContent, FalseContent> where TrueContent : APView, FalseContent : APView {
        APConditionalContent(first: first)
    }
    @_alwaysEmitIntoClient
    public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> APConditionalContent<TrueContent, FalseContent> where TrueContent : APView, FalseContent : APView {
        APConditionalContent(second: second)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some APView where C0 : APView, C1 : APView {
        TupleView((c0, c1))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some APView where C0 : APView, C1 : APView, C2 : APView {
        TupleView((c0, c1, c2))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView {
        TupleView((c0, c1, c2, c3))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView {
        TupleView((c0, c1, c2, c3, c4))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView {
        TupleView((c0, c1, c2, c3, c4, c5))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView {
        TupleView((c0, c1, c2, c3, c4, c5, c6))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView, C8 : APView {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView, C8 : APView, C9 : APView {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c9))
    }
}

extension TupleView: APView {}
extension EmptyView: APView {}

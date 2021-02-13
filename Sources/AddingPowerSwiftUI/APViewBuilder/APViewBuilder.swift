//
//  APViewBuilder.swift
//  Navigation
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public protocol APView: View {}

@_functionBuilder
public struct APViewBuilder {
    
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }
    
    public static func buildExpression<Content>(_ content: Content) -> some View where Content : View {
        APUnaryContent(content)
    }
    
    public static func buildExpression<Content>(_ content: Content) -> some View where Content : APView {
        content
    }
    
    public static func buildBlock<Content>(_ content: Content) -> some View where Content : View {
        content
    }
}

extension APViewBuilder {
    
    public static func buildIf<Content>(_ content: Content?) -> some View where Content : View {
        APOptionalContent(content)
    }
    
    @_alwaysEmitIntoClient
    public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> APConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
        APConditionalContent(first: first)
    }
    @_alwaysEmitIntoClient
    public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> APConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
        APConditionalContent(second: second)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some View where C0 : View, C1 : View {
        TupleView((c0, c1))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some View where C0 : View, C1 : View, C2 : View {
        TupleView((c0, c1, c2))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some View where C0 : View, C1 : View, C2 : View, C3 : View {
        TupleView((c0, c1, c2, c3))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View {
        TupleView((c0, c1, c2, c3, c4))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View {
        TupleView((c0, c1, c2, c3, c4, c5))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some View where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c9))
    }
}

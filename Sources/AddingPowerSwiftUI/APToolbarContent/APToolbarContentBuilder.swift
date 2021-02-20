//
//  SwiftUIView.swift
//  
//
//

import SwiftUI

@_functionBuilder
public struct APToolbarContentBuilder {
    
    public static func buildExpression<Content>(_ content: Content) -> some APView where Content : APToolbarContent {
        APToolbarUnaryContent(content)
    }
    
    public static func buildBlock<Content>(_ content: Content) -> some APView where Content : APView {
        content
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some APView where C0 : APView, C1 : APView {
        TupleView<(C0, C1)>((c0, c1))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some APView where C0 : APView, C1 : APView, C2 : APView {
        TupleView<(C0, C1, C2)>((c0, c1, c2))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView {
        TupleView<(C0, C1, C2, C3)>((c0, c1, c2, c3))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView {
        TupleView<(C0, C1, C2, C3, C4)>((c0, c1, c2, c3, c4))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView {
        TupleView<(C0, C1, C2, C3, C4, C5)>((c0, c1, c2, c3, c4, c5))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView {
        TupleView<(C0, C1, C2, C3, C4, C5, C6)>((c0, c1, c2, c3, c4, c5, c6))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView {
        TupleView<(C0, C1, C2, C3, C4, C5, C6, C7)>((c0, c1, c2, c3, c4, c5, c6, c7))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView, C8 : APView {
        TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)>((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
    
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some APView where C0 : APView, C1 : APView, C2 : APView, C3 : APView, C4 : APView, C5 : APView, C6 : APView, C7 : APView, C8 : APView, C9 : APView {
        TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)>((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9))
    }
    
}

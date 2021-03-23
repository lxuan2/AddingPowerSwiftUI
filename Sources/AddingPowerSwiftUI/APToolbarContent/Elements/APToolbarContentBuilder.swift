//
//  APToolbarContentBuilder.swift
//  
//
//

import SwiftUI

@_functionBuilder
public struct APToolbarContentBuilder {
    public static func buildBlock<Content>(_ content: Content) -> Content where Content : APToolbarContent {
        content
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent, C5 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4), C5._makeContent(content: c5)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent, C5 : APToolbarContent, C6 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4), C5._makeContent(content: c5), C6._makeContent(content: c6)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent, C5 : APToolbarContent, C6 : APToolbarContent, C7 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4), C5._makeContent(content: c5), C6._makeContent(content: c6), C7._makeContent(content: c7)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent, C5 : APToolbarContent, C6 : APToolbarContent, C7 : APToolbarContent, C8 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4), C5._makeContent(content: c5), C6._makeContent(content: c6), C7._makeContent(content: c7), C8._makeContent(content: c8)))
    }
}

extension APToolbarContentBuilder {
    @_alwaysEmitIntoClient public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some APToolbarContent where C0 : APToolbarContent, C1 : APToolbarContent, C2 : APToolbarContent, C3 : APToolbarContent, C4 : APToolbarContent, C5 : APToolbarContent, C6 : APToolbarContent, C7 : APToolbarContent, C8 : APToolbarContent, C9 : APToolbarContent {
        APTupleToolbarContent((C0._makeContent(content: c0), C1._makeContent(content: c1), C2._makeContent(content: c2), C3._makeContent(content: c3), C4._makeContent(content: c4), C5._makeContent(content: c5), C6._makeContent(content: c6), C7._makeContent(content: c7), C8._makeContent(content: c8), C9._makeContent(content: c9)))
    }
}

@usableFromInline
struct APTupleToolbarContent<T> : APToolbarContent {
    var value: TupleView<T>
    
    @usableFromInline
    init(_ value: T) {
        self.value = TupleView(value)
    }
    
    @usableFromInline
    static func _makeContent(content: APTupleToolbarContent<T>) -> some View {
        content.value
    }
}

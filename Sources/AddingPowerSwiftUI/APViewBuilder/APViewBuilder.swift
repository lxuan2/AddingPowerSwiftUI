//
//  APViewBuilder.swift
//  Navigation
//
//  Created by Xuan Li on 2/5/21.
//

import SwiftUI

public typealias APView = ViewModifier

@_functionBuilder
public struct APViewBuilder {
    
    public static func buildBlock() -> EmptyModifier {
        EmptyModifier()
    }
    
    public static func buildExpression<Content>(_ content: Content) -> some ViewModifier where Content : View {
        APUnaryViewModifier(content)
    }
    
    public static func buildBlock<Content>(_ content: Content) -> some ViewModifier where Content : ViewModifier {
        content
    }
}

extension APViewBuilder {
    
    public static func buildIf<Content>(_ content: Content?) -> some ViewModifier where Content : ViewModifier {
        APOptionalViewModifier(content)
    }
    
    @_alwaysEmitIntoClient public static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _APConditionalContent<TrueContent, FalseContent> where TrueContent : ViewModifier, FalseContent : ViewModifier {
        _APConditionalContent(storage: .trueContent(first))
    }
    @_alwaysEmitIntoClient public static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> _APConditionalContent<TrueContent, FalseContent> where TrueContent : ViewModifier, FalseContent : ViewModifier {
        _APConditionalContent(storage: .falseContent(second))
    }
}

extension APViewBuilder {
    
    public static func buildExpression<C0, C1>(_ c0: C0, _ c1: C1) -> some ViewModifier where C0 : View, C1 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
    }
    
    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier {
        c0
            .concat(c1)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some ViewModifier where C0 : View, C1 : View, C2 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
    }
    
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
    }
    
    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
            .concat(APUnaryViewModifier(c5))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier, C5 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
            .concat(c5)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
            .concat(APUnaryViewModifier(c5))
            .concat(APUnaryViewModifier(c6))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier, C5 : ViewModifier, C6 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
            .concat(c5)
            .concat(c6)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
            .concat(APUnaryViewModifier(c5))
            .concat(APUnaryViewModifier(c6))
            .concat(APUnaryViewModifier(c7))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier, C5 : ViewModifier, C6 : ViewModifier, C7 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
            .concat(c5)
            .concat(c6)
            .concat(c7)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
            .concat(APUnaryViewModifier(c5))
            .concat(APUnaryViewModifier(c6))
            .concat(APUnaryViewModifier(c7))
            .concat(APUnaryViewModifier(c8))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier, C5 : ViewModifier, C6 : ViewModifier, C7 : ViewModifier, C8 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
            .concat(c5)
            .concat(c6)
            .concat(c7)
            .concat(c8)
    }
}

extension APViewBuilder {
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some ViewModifier where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View {
        APUnaryViewModifier(c0)
            .concat(APUnaryViewModifier(c1))
            .concat(APUnaryViewModifier(c2))
            .concat(APUnaryViewModifier(c3))
            .concat(APUnaryViewModifier(c4))
            .concat(APUnaryViewModifier(c5))
            .concat(APUnaryViewModifier(c6))
            .concat(APUnaryViewModifier(c7))
            .concat(APUnaryViewModifier(c8))
            .concat(APUnaryViewModifier(c9))
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some ViewModifier where C0 : ViewModifier, C1 : ViewModifier, C2 : ViewModifier, C3 : ViewModifier, C4 : ViewModifier, C5 : ViewModifier, C6 : ViewModifier, C7 : ViewModifier, C8 : ViewModifier, C9 : ViewModifier {
        c0
            .concat(c1)
            .concat(c2)
            .concat(c3)
            .concat(c4)
            .concat(c5)
            .concat(c6)
            .concat(c7)
            .concat(c8)
            .concat(c9)
    }
}

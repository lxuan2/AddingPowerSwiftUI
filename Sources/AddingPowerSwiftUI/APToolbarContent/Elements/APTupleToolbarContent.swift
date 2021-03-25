//
//  APTupleToolbarContent.swift
//  
//
//  Created by Xuan Li on 3/25/21.
//

import SwiftUI

@usableFromInline
struct APTupleToolbarContent<T> : APToolbarContent {
    var value: T
    
    @usableFromInline
    init(_ value: T) {
        self.value = value
    }
    
    @usableFromInline
    var body: some View {
        TupleView(value)
    }
    
    @usableFromInline
    var contentBody: Never {
        fatalError()
    }
}

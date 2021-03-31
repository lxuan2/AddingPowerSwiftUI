//
//  APGroup.swift
//  
//
//  Created by Xuan Li on 3/30/21.
//

import SwiftUI

@frozen public struct APGroup<Content> {
    public var content: Content
}

extension APGroup: View where Content: View {
    @inlinable public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Group {
            content
        }
    }
}

extension APGroup : APToolbarContent where Content : APToolbarContent {
    @inlinable public init(@APToolbarContentBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var contentBody: Never {
        fatalError()
    }
}

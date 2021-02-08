//
//  APCatchModifier.swift
//  
//
//  Created by Xuan Li on 2/8/21.
//

import SwiftUI

public struct APCatchModifier<Delegate: APMonitorDelegate>: ViewModifier {
    let delegate: Delegate
    @StateObject var object = APMonitorObject()
    
    public func body(content: Content) -> some View {
        content
            .onPreferenceChange(APViewBuilderPreferenceKey.self) { current in
                delegate.updateViews(from: object.previous, to: current)
                object.previous = current
            }
    }
}

extension View {
    public func catchViews<Delegate: APMonitorDelegate>(_ delegate: Delegate) -> some View {
        self.modifier(APCatchModifier(delegate: delegate))
    }
}


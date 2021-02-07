//
//  APMonitorModifier.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

struct APMonitorModifier<V: APView, Delegate: APMonitorDelegate>: ViewModifier {
    let view: V
    let delegate: Delegate
    @StateObject var object = APMonitorObject()
    
    func body(content: Content) -> some View {
        content
            .modifier(view)
            .onPreferenceChange(APViewBuilderPreferenceKey.self) { current in
                delegate.updateViews(from: object.previous, to: current)
                object.previous = current
            }
    }
    
    class APMonitorObject: ObservableObject {
        var previous: [APAnySynView] = []
    }
}

extension View {
    public func monitorViews<V: APView, MonitorDelegate: APMonitorDelegate>(_ view: V, _ delegate: MonitorDelegate) -> some View {
        self.modifier(APMonitorModifier(view: view, delegate: delegate))
    }
}

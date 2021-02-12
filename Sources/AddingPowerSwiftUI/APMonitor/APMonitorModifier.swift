//
//  APMonitorModifier.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

//struct APMonitorModifier<V: _APVariadicView, Delegate: APMonitorDelegate>: ViewModifier {
//    let view: V
//    let delegate: Delegate
//    @StateObject var object = APMonitorObject()
//    @StateObject private var storage = APAnySynViewStorage<Color>()
//    
//    func body(content: Content) -> some View {
//        storage.updateView(Color.green)
//        return content
//            .modifier(view)
//            .preference(key: __APVariadicView_PreferenceKey.self, value: APVariadicView_Root(proxy: nil, body: [APAnySynView(storage: storage)]))
//            .onPreferenceChange(__APVariadicView_PreferenceKey.self) { root in
////                delegate.updateViews(from: object.previous, to: current)
////                object.previous = current
//                let current = traverseTree(root: root)
//                delegate.updateViews(from: object.previous, to: current)
//                object.previous = current
//            }
//    }
//}
//
//class APMonitorObject: ObservableObject {
//    var previous: [APAnySynView] = []
//}
//
//extension View {
//    public func monitorViews<V: _APVariadicView, Delegate: APMonitorDelegate>(_ view: V, _ delegate: Delegate) -> some View {
//        self.modifier(APMonitorModifier(view: view, delegate: delegate))
//    }
//}

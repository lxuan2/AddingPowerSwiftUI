//
//  APCatchModifier.swift
//  
//
//  Created by Xuan Li on 2/8/21.
//

//import SwiftUI
//
//public struct APCatchModifier<Delegate: APMonitorDelegate>: ViewModifier {
//    let delegate: Delegate
//    @StateObject var object = APMonitorObject()
//
//    public func body(content: Content) -> some View {
//        content
//            .onPreferenceChange(__APVariadicView_PreferenceKey.self) { root in
//                let current = traverseTree(root: root)
//                delegate.updateViews(from: object.previous, to: current)
//                object.previous = current
//            }
//    }
//}
//
//extension View {
//    public func catchViews<Delegate: APMonitorDelegate>(_ delegate: Delegate) -> some View {
//        self.modifier(APCatchModifier(delegate: delegate))
//    }
//}
//
//func traverseTree(root: APVariadicView_MultiViewRoot) -> [APAnySynView] {
//    if root.proxy == nil {
//        return root.body
//    }
//    return traverseTree(root: root.proxy!.previous_body) + traverseTree(root: root.proxy!.body) + root.body
//}

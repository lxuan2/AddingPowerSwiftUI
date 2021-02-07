//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView: View {
    @State var navigationController = APNavigationControllerHolder()
    @State var root: APAnySynView? = nil
    let content: Content
    
    public var body: some View {
        APStackNavigationHostingView(root: root, navigationController: $navigationController)
            .equatable()
            .environment(\.apNavigationController, navigationController)
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                navigationController.vc?.setNavigationBarHidden(hidden, animated: true)
            }
            .background(content.catchViews(APStackNavigationDelegate(content: $root)))
    }
    
    public init(content: Content) {
        self.content = content
    }
    
    public typealias Content = _ViewModifier_Content<_APNavigationViewStyleModifier>
}

public struct APStackNavigationDelegate: APMonitorDelegate {
    let content: Binding<APAnySynView?>
    
    public func updateViews(from previous: [APAnySynView], to current: [APAnySynView]) {
        content.wrappedValue = current.first!
    }
    
    public init(content: Binding<APAnySynView?>) {
        self.content = content
    }
}

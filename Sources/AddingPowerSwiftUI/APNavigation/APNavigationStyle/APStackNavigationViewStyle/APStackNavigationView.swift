//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView<RootSource: View>: View {
    @State var navigationController = APNavigationControllerHolder()
    @State var root: APAnySynView? = nil
    let rootSource: RootSource
    
    public var body: some View {
        APStackNavigationHostingView(root: root, navigationController: $navigationController)
            .equatable()
            .environment(\.apNavigationController, navigationController)
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                navigationController.vc?.setNavigationBarHidden(hidden, animated: true)
            }
            .edgesIgnoringSafeArea(.all)
            .background(rootSource.catchViews(MonitorDelegate(content: $root)))
    }
    
    public init(rootSource: RootSource) {
        self.rootSource = rootSource
    }
    
    public init<Content: APView>(@APViewBuilder content: () -> Content) where RootSource == ModifiedContent<Spacer, Content> {
        self.rootSource = Spacer().modifier(content())
    }
    
    public struct MonitorDelegate: APMonitorDelegate {
        let content: Binding<APAnySynView?>
        
        public func updateViews(from previous: [APAnySynView], to current: [APAnySynView]) {
            content.wrappedValue = current.first!
        }
        
        public init(content: Binding<APAnySynView?>) {
            self.content = content
        }
    }

}

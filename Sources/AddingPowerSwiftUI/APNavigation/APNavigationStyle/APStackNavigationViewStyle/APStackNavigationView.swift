//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView<Source: View>: View {
    @StateObject var nvc = APNavigationController(rootViewController: UIViewController())
    let source: Source
    
    public var body: some View {
        APNavigationHostingView(nvc: nvc)
            .environment(\.apNavigationController, APNavigationControllerHolder(vc: nvc))
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                nvc.setNavigationBarHidden(hidden, animated: true)
            }
            .edgesIgnoringSafeArea(.all)
            .background(source.catchViews(MonitorDelegate(nvc: nvc)))
    }
    
    public init(source: Source) {
        self.source = source
    }
    
    public init<Content: APView>(@APViewBuilder content: () -> Content) where Source == ModifiedContent<Spacer, Content> {
        self.source = Spacer().modifier(content())
    }
}

extension APStackNavigationView {
    private struct MonitorDelegate: APMonitorDelegate {
        weak var nvc: UINavigationController?
        
        func updateViews(from previous: [APAnySynView], to current: [APAnySynView]) {
            if (current.first != previous.first) {
                let rvc = APNavigationPageController(rootView: current.first.edgesIgnoringSafeArea(.all))
                nvc!.viewControllers[0] = rvc
            }
        }
        
        init(nvc: UINavigationController?) {
            self.nvc = nvc
        }
    }
}

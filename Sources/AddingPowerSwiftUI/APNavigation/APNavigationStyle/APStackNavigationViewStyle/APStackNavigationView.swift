//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView: APVariadicView_PrimitiveRoot {
    public func makeBody(configuration: APVariadicViewPrimitiveConfiguration) -> some View {
        _APStackNavigationView(configuration: configuration)
    }
}

public struct _APStackNavigationView: View {
    @StateObject private var nvc = APNavigationController()
    let configuration: APVariadicViewPrimitiveConfiguration
    
    public var body: some View {
        APNavigationHostingView(nvc: nvc)
            .environment(\.apNavigationController, APNavigationControllerHolder(vc: nvc))
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                nvc.setNavigationBarHidden(hidden, animated: true)
            }
            .edgesIgnoringSafeArea(.all)
            .onReceive(configuration.rootInit) {
                handleRootInit()
            }
            .onReceive(configuration.viewRootReplace) {
                handleChange(viewRoot: $0.0, $0.1)
            }
            .onReceive(configuration.viewRootModification) {
                handleChange(viewRoot: $0.0, $0.1)
            }
    }
    
    public func handleRootInit() {
        if let (location, view) = configuration.root.getLocationAndView(at: 0) {
            nvc.root = view
            nvc.rootLocation = location
        }
    }
    
    public func handleChange(viewRoot: APVariadicView_MultiViewRoot, _ oldStorage: [APVariadicView]) {
        if let loc = nvc.rootLocation {
            if loc.contains(viewRoot.location!) {
                if let v = loc.findView(in: configuration.root) {
                    nvc.root = v
                } else {
                    nvc.root = nil
                }
            }
        } else {
            handleRootInit()
        }
    }
}

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
    @StateObject private var nvc = APNavigationController(rootViewController: UIViewController())
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
            .onReceive(configuration.viewRootChange) {
                handleRootReplace(viewRoot: $0.0, $0.1)
            }
            .onReceive(configuration.viewRootReplace) {
                handleRootReplace(viewRoot: $0.0, $0.1)
            }
            .onReceive(configuration.viewRootModification) {
                handleRootReplace(viewRoot: $0.0, $0.1)
            }
    }
    
    public func handleRootInit() {
        if let (location, view) = configuration.root.getLocationAndView(at: 0) {
            nvc.viewControllers[0] = APNavigationPageController(rootView: view.edgesIgnoringSafeArea(.all))
            nvc.rootLocation = location
        }
    }
    
    public func handleRootReplace(viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView]) {
        viewRoot.storage = newStorage
        if let loc = nvc.rootLocation {
            if loc.contains(viewRoot.location!) {
                nvc.viewControllers[0] = UIViewController()
                nvc.rootLocation = nil
            }
        } else {
            handleRootInit()
        }
    }
}

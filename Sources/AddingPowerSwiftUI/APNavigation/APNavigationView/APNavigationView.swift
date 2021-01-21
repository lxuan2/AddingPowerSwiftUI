//
//  APNavigationView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationView<Master: View, Detail: View>: View {
    let master: Master
    let detail: Detail?
    @State var navigationController = APNavigationControllerHolder()

    public var body: some View {
        APNavigationHostingView(master: master, detail: detail, navigationController: $navigationController)
            .environment(\.apNavigationController, navigationController)
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                navigationController.vc?.setNavigationBarHidden(hidden, animated: true)
            }
    }
    
    public init(@ViewBuilder content: () -> TupleView<(Master, Detail)>) {
        let c = content().value
        master = c.0
        detail = c.1
    }
}

extension APNavigationView where Detail == Never {
    public init(content: () -> Master) {
        master = content()
        detail = nil
    }
}

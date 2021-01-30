//
//  APStackNavigationView.swift
//  
//
//  Created by Xuan Li on 1/23/21.
//

import SwiftUI

public struct APStackNavigationView<Content: View>: View {
    @State var navigationController = APNavigationControllerHolder()
    let content: Content
    
    public var body: some View {
        APStackNavigationHostingView(master: content, detail: content, navigationController: $navigationController)
            .environment(\.apNavigationController, navigationController)
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(APNavigationBarHiddenPreferenceKey.self) { hidden in
                navigationController.vc?.setNavigationBarHidden(hidden, animated: true)
            }
    }
}

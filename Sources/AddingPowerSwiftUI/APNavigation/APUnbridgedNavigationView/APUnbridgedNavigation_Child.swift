//
//  APUnbridgedNavigation_Child.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

//public struct APUnbridgedNavigation_Child<Content: View>: View {
//    var content: Content
//    
//    public var body: some View {
//        content
//            
//    }
//}

public struct APUnbridgedNavigation_ChildModifier: ViewModifier {
    var configuration: APUnbridgedNavigationConfiguration
    
    public func body(content: Content) -> some View {
        content
            .onPreferenceChange(APNavigationTitleKey.self) {
                configuration.setTitle($0)
            }
            .onPreferenceChange(APNavigationTitleDisplayModeKey.self) {
                configuration.setTitleDisplayMode($0)
            }
            .onPreferenceChange(APNavigationBackButtonDisplayModeKey.self) {
                configuration.setBackButtonDisplayMode($0)
            }
            .onPreferenceChange(APNavigationPromptKey.self) {
                configuration.setPrompt($0)
            }
            .onPreferenceChange(APNavigationBarBackButtonHiddenKey.self) {
                configuration.setHidesBackButton($0)
            }
            .onPreferenceChange(APNavigationBackButtonTitleKey.self) {
                configuration.setBackButtonTitle($0)
            }
            .onPreferenceChange(APNavigationBarHiddenKey.self) { hidden in
                configuration.setNavigationBarHidden(hidden)
            }
            .onPreferenceChange(APToolBarItemPayloadKey.self) { payload in
                configuration.setBarItemPayload(payload)
            }
    }
}

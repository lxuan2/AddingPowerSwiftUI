//
//  APNavigationBridgeModifier.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

// MARK: - APNavigationBridgeModifier

public struct APNavigationBridgeModifier: ViewModifier {
    var configuration: APNavigationBridge
    
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
            .onPreferenceChange(APNavigationBarHiddenKey.self) {
                configuration.setNavigationBarHidden($0)
            }
            .onPreferenceChange(APToolBarItemPayloadKey.self) {
                configuration.setBarItemPayload($0)
            }
    }
}

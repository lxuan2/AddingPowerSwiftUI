//
//  APNavigationPageView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationPageView<Content: View>: View {
    let content: Content
    weak var navigationItem: UINavigationItem?
    @State var title: UUID?
    
    public var body: some View {
        content
            .apNavigationTitleEnd(navigationItem: navigationItem)
            .onPreferenceChange(APNavigationTitleDisplayModePreferenceKey.self) { displayMode in
                var mode: UINavigationItem.LargeTitleDisplayMode
                switch displayMode {
                case .automatic:
                    mode = .automatic
                case .inline:
                    mode = .never
                case .large:
                    mode = .always
                }
                navigationItem?.largeTitleDisplayMode = mode
            }
            .onPreferenceChange(APNavigationBackButtonDisplayModePreferenceKey.self) { displayMode in
                var mode: UINavigationItem.BackButtonDisplayMode
                switch displayMode {
                case .default:
                    mode = .default
                case .generic:
                    mode = .generic
                case .minimal:
                    mode = .minimal
                }
                navigationItem?.backButtonDisplayMode = mode
            }
            .onPreferenceChange(APNavigationPromptPreferenceKey.self) { prompt in
                navigationItem?.prompt = prompt
            }
            .onPreferenceChange(APNavigationBarBackButtonHiddenPreferenceKey.self) { hidesBackButton in
                navigationItem?.hidesBackButton = hidesBackButton
            }
    }
}


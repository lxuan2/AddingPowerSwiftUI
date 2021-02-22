//
//  APNavigationPageView.swift
//  
//
//

import SwiftUI

public struct APNavigationPageView<Content: View>: View {
    let content: Content
    unowned var navigationItem: UINavigationItem!
    
    public var body: some View {
        content
            .onPreferenceChange(APNavigationTitlePreferenceKey.self) { title in
                navigationItem.title = title
            }
            .onPreferenceChange(APNavigationTitleViewPreferenceKey.self) { title in
                navigationItem.titleView = title?.getView()
            }
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
                navigationItem.largeTitleDisplayMode = mode
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
                navigationItem.backButtonDisplayMode = mode
            }
            .onPreferenceChange(APNavigationPromptPreferenceKey.self) { prompt in
                navigationItem.prompt = prompt
            }
            .onPreferenceChange(APNavigationBarBackButtonHiddenPreferenceKey.self) { hidesBackButton in
                navigationItem.hidesBackButton = hidesBackButton
            }
            .onPreferenceChange(APNavigationBackButtonTitlePreferenceKey.self) { title in
                navigationItem.backButtonTitle = title
            }
            .onPreferenceChange(APNavigationLeftItemsSupplementBackButtonPreferenceKey.self) { isSupplement in
                navigationItem.leftItemsSupplementBackButton = isSupplement
            }
    }
}


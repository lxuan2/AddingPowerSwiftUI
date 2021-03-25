//
//  APNavigationPageConfigurationModifier.swift
//  
//
//  Created by Xuan Li on 3/19/21.
//

import SwiftUI

struct APNavigationPageConfigurationModifier: ViewModifier {
    unowned var navigationItem: UINavigationItem!
    unowned var vc: UIViewController!
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(APNavigationTitleKey.self) { title in
                navigationItem.title = title
            }
            .onPreferenceChange(APNavigationTitleDisplayModeKey.self) { displayMode in
                var mode: UINavigationItem.LargeTitleDisplayMode
                if let dm = displayMode {
                    switch dm {
                    case .automatic:
                        mode = .automatic
                    case .inline:
                        mode = .never
                    case .large:
                        mode = .always
                    }
                } else {
                    mode = .automatic
                }
                navigationItem.largeTitleDisplayMode = mode
            }
            .onPreferenceChange(APNavigationBackButtonDisplayModeKey.self) { displayMode in
                var mode: UINavigationItem.BackButtonDisplayMode
                if let dm = displayMode {
                    switch dm {
                    case .automatic:
                        mode = .default
                    case .generic:
                        mode = .generic
                    case .minimal:
                        mode = .minimal
                    }
                } else {
                    mode = .default
                }
                navigationItem.backButtonDisplayMode = mode
            }
            .onPreferenceChange(APNavigationPromptKey.self) { prompt in
                navigationItem.prompt = prompt
            }
            .onPreferenceChange(APNavigationBarBackButtonHiddenKey.self) { hidesBackButton in
                navigationItem.hidesBackButton = hidesBackButton ?? false
            }
            .onPreferenceChange(APNavigationBackButtonTitleKey.self) { title in
                navigationItem.backButtonTitle = title
            }
            .onPreferenceChange(APNavigationLeftItemsSupplementBackButtonKey.self) { isSupplement in
                navigationItem.leftItemsSupplementBackButton = isSupplement ?? false
            }
            .modifier(APToolbarModifier(navigationItem: navigationItem, vc: vc))
            .onPreferenceChange(APNavigationBarHiddenKey.self) { hidden in
                vc.navigationController?.isNavigationBarHidden = hidden ?? false
            }
    }
}

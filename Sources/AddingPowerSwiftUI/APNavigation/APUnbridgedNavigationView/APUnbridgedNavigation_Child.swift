//
//  APUnbridgedNavigation_Child.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

public struct APUnbridgedNavigation_Child<Content: View>: View {
    var content: Content
    unowned var navigationItem: UINavigationItem!
    unowned var vc: UIViewController!
    
    public var body: some View {
        content
            .onPreferenceChange(APNavigationTitleKey.self) { title in
                navigationItem.title = title
            }
            .onPreferenceChange(APNavigationTitleDisplayModeKey.self) { displayMode in
                navigationItem.largeTitleDisplayMode = displayMode?.asUIElement() ?? .automatic
            }
            .onPreferenceChange(APNavigationBackButtonDisplayModeKey.self) { displayMode in
                navigationItem.backButtonDisplayMode = displayMode?.asUIElement() ?? .default
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
            .onPreferenceChange(APNavigationBarHiddenKey.self) { hidden in
                vc.navigationController?.setNavigationBarHidden(hidden ?? false, animated: true)
            }
            .onPreferenceChange(APToolBarItemPayloadKey.self) { payload in
                navigationItem.titleView = payload.title?.getView()
                navigationItem.setRightBarButtonItems(payload.topRightBarButtonItems.map { $0.getBarButtonItem() }, animated: true)
                navigationItem.setLeftBarButtonItems(payload.topLeftBarButtonItems.map { $0.getBarButtonItem() }, animated: true)
                navigationItem.backBarButtonItem = payload.backBarButtonItem.map { $0.getBarButtonItem() }
                vc.setToolbarItems(payload.bottomBarItems.map { $0.getBarButtonItem() }, animated: true)
                vc.navigationController?.setToolbarHidden(vc.toolbarItems!.isEmpty, animated: true)
            }
            
    }
}

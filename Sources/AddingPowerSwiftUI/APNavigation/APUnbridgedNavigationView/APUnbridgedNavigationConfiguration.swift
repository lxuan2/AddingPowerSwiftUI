//
//  APUnbridgedNavigationConfiguration.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

struct APUnbridgedNavigationConfiguration {
    class Provider {
        unowned var vc: UIViewController!
        var animationEnabled: Bool
        var isNavigationBarHidden: Bool?
        
        init(viewController: UIViewController?, animationEnabled: Bool = true) {
            self.vc = viewController
            self.animationEnabled = animationEnabled
            self.isNavigationBarHidden = nil
        }
    }
    
    init(viewController: UIViewController?, animationEnabled: Bool = true) {
        provider = .init(viewController: viewController, animationEnabled: animationEnabled)
    }
    
    private var provider: Provider
    
    func setTitle(_ title: String?) {
        provider.vc.title = title
    }
    var title: String? {
        provider.vc.title
    }
    
    func setTitleDisplayMode(_ displayMode: APNavigationBarItem.TitleDisplayMode?) {
        provider.vc.navigationItem.largeTitleDisplayMode = displayMode?.asUIElement() ?? .automatic
    }
    
    var titleDisplayMode: APNavigationBarItem.TitleDisplayMode {
        switch provider.vc.navigationItem.largeTitleDisplayMode {
        case .always:
            return .large
        case .automatic:
            return .automatic
        case .never:
            return .inline
        @unknown default:
            return .automatic
        }
    }
    
    func setBackButtonDisplayMode(_ displayMode: APNavigationBarItem.BackButtonDisplayMode?) {
        provider.vc.navigationItem.backButtonDisplayMode = displayMode?.asUIElement() ?? .default
    }
    
    var backButtonDisplayMode: APNavigationBarItem.BackButtonDisplayMode {
        switch provider.vc.navigationItem.backButtonDisplayMode {
        case .default:
            return .automatic
        case .generic:
            return .generic
        case .minimal:
            return .minimal
        @unknown default:
            return .automatic
        }
    }
    
    func setPrompt(_ prompt: String?) {
        provider.vc.navigationItem.prompt = prompt
    }
    var prompt: String? {
        provider.vc.navigationItem.prompt
    }
    
    func setHidesBackButton(_ hidden: Bool?) {
        provider.vc.navigationItem.setHidesBackButton(hidden ?? false, animated: provider.animationEnabled)
    }
    
    var hidesBackButton: Bool? {
        provider.vc.navigationItem.hidesBackButton
    }
    
    func setBackButtonTitle(_ title: String?) {
        provider.vc.navigationItem.backButtonTitle = title
    }
    
    var backButtonTitle: String? {
            provider.vc.navigationItem.backButtonTitle
    }
    
    func setNavigationBarHidden(_ hidden: Bool?) {
        provider.vc.navigationController?.setNavigationBarHidden(hidden ?? false, animated: provider.animationEnabled)
        provider.isNavigationBarHidden = hidden ?? false
    }
    
    var navigationBarHidden: Bool {
        provider.vc.navigationController!.isNavigationBarHidden
    }
    
    func setBarItemPayload(_ payload: APBarButtonItemPayload?) {
        provider.vc.navigationItem.titleView = payload?.title?.getView()
        provider.vc.navigationItem.setRightBarButtonItems(payload?.topRightBarButtonItems.map { $0.getBarButtonItem() },
                                                          animated: provider.animationEnabled)
        provider.vc.navigationItem.setLeftBarButtonItems(payload?.topLeftBarButtonItems.map { $0.getBarButtonItem() },
                                                         animated: provider.animationEnabled)
        provider.vc.navigationItem.backBarButtonItem = payload?.backBarButtonItem.map { $0.getBarButtonItem() }
        provider.vc.setToolbarItems(payload?.bottomBarItems.map { $0.getBarButtonItem() },
                                    animated: provider.animationEnabled)
        provider.vc.navigationController?.setToolbarHidden(provider.vc.toolbarItems!.isEmpty,
                                                           animated: provider.animationEnabled)
    }
    
    func setViewController(_ viewController: UIViewController?) {
        provider.vc = viewController
    }
    
    func viewWillAppear() {
        let toolbarHidden = provider.vc.toolbarItems?.isEmpty ?? true
        if toolbarHidden != provider.vc.navigationController?.isToolbarHidden {
            provider.vc.navigationController?.setToolbarHidden(toolbarHidden, animated: provider.animationEnabled)
        }
        if let hidden = provider.isNavigationBarHidden, provider.vc.navigationController?.isNavigationBarHidden != hidden {
            provider.vc.navigationController?.setNavigationBarHidden(hidden, animated: provider.animationEnabled)
        }
    }
}

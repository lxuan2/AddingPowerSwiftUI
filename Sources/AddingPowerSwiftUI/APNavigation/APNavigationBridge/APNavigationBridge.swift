//
//  APNavigationBridge.swift
//  
//
//  Created by Xuan Li on 3/27/21.
//

import SwiftUI

// MARK: - APNavigationBridge

struct APNavigationBridge {
    final class Provider {
        unowned var vc: UIViewController!
        unowned var nvc: UINavigationController!
        var animationEnabled: Bool
        var animationEnabledOnInit: Bool
        var isNavigationBarHidden: Bool? = nil
        var isPayloadInited: Bool = false
        var isInited: Bool = false
        
        init(nvc: UINavigationController?, vc: UIViewController?, animationEnabled: Bool, animationEnabledOnInit: Bool) {
            self.vc = vc
            self.nvc = nvc
            self.animationEnabled = animationEnabled
            self.animationEnabledOnInit = animationEnabledOnInit
        }
    }
    
    init(nvc: UINavigationController?, vc: UIViewController?, animationEnabled: Bool = true, animationEnabledOnInit: Bool = true) {
        provider = .init(nvc: nvc, vc: vc, animationEnabled: animationEnabled, animationEnabledOnInit: animationEnabledOnInit)
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
        let h = hidden ?? false
        var animated = provider.animationEnabled
        if provider.isNavigationBarHidden == nil {
            animated = animated && provider.animationEnabledOnInit
        }
        provider.nvc.setNavigationBarHidden(h, animated: animated)
        provider.isNavigationBarHidden = h
    }
    
    var navigationBarHidden: Bool {
        provider.nvc.isNavigationBarHidden
    }
    
    func setBarItemPayload(_ payload: APBarButtonItemPayload?) {
        var animated = provider.animationEnabled
        if !provider.isPayloadInited {
            provider.isPayloadInited = true
            animated = animated && provider.animationEnabledOnInit
        }
        provider.vc.navigationItem.titleView = payload?.title?.getView()
        provider.vc.navigationItem.setRightBarButtonItems(payload?.topRightBarButtonItems.map { $0.getBarButtonItem() },
                                                          animated: animated)
        provider.vc.navigationItem.setLeftBarButtonItems(payload?.topLeftBarButtonItems.map { $0.getBarButtonItem() },
                                                         animated: animated)
        provider.vc.navigationItem.backBarButtonItem = payload?.backBarButtonItem.map { $0.getBarButtonItem() }
        provider.vc.setToolbarItems(payload?.bottomBarItems.map { $0.getBarButtonItem() },
                                    animated: animated)
        provider.nvc.setToolbarHidden(provider.vc.toolbarItems!.isEmpty,animated: animated)
    }
    
    func setViewController(_ vc: UIViewController?) {
        provider.vc = vc
    }
    
    func setNavigationController(_ nvc: UINavigationController?) {
        provider.nvc = nvc
    }
    
    func setAnimationEnabled(_ enabled: Bool) {
        provider.animationEnabled = enabled
    }
    
    func viewWillAppear() {
        if provider.isInited {
            let toolbarHidden = provider.vc.toolbarItems?.isEmpty ?? true
            if toolbarHidden != provider.nvc.isToolbarHidden {
                provider.nvc.setToolbarHidden(toolbarHidden, animated: provider.animationEnabled)
            }
            if let hidden = provider.isNavigationBarHidden, provider.nvc.isNavigationBarHidden != hidden {
                provider.nvc.setNavigationBarHidden(hidden, animated: provider.animationEnabled)
            }
        } else {
            provider.isInited = true
        }
    }
}

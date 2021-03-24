//
//  APToolbarModifier.swift
//  
//
//  Created by Xuan Li on 3/17/21.
//

import SwiftUI

struct APToolbarModifier: ViewModifier {
    unowned var navigationItem: UINavigationItem!
    unowned var vc: UIViewController!
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(APToolBarItemPayloadKey.self) { payload in
                navigationItem.titleView = payload.title?.getView()
                navigationItem.rightBarButtonItems = payload.topRightBarButtonItems.map { $0.getBarButtonItem() }
                navigationItem.leftBarButtonItems = payload.topLeftBarButtonItems.map { $0.getBarButtonItem() }
                vc.toolbarItems = payload.bottomBarItems.map { $0.getBarButtonItem() }
                vc.navigationController?.isToolbarHidden = vc.toolbarItems!.isEmpty
            }
    }
}

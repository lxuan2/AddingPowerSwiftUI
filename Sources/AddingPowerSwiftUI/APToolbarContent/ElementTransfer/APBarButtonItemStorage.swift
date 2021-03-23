//
//  APBarButtonItemStorage.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

class APBarButtonItemStorage: ObservableObject {
    let isGroup: Bool
    var isChanged: Bool = false
    var rootView: _VariadicView.Children.Element? = nil
    weak var subscriber: APUIHostingBarButtonItem?
    weak var viewSubscriber: UIHostingView<_VariadicView.Children.Element>?
    
    init(isGroup: Bool) {
        self.isGroup = isGroup
    }
    
    func getBarButtonItem() -> UIBarButtonItem {
        if let s = subscriber {
            return s
        }
        let s = APUIHostingBarButtonItem(rootView: rootView!)
        subscriber = s
        return s
    }
    
    func getView() -> UIView {
        if let s = viewSubscriber {
            return s
        }
        let s = UIHostingView(rootView: rootView!)
        viewSubscriber = s
        return s
    }
    
    func updateRootView(_ root: _VariadicView.Children.Element) {
        if let s = subscriber {
            s.rootView = root
        }
        if let s = viewSubscriber {
            s.rootView = root
        }
        let needUpdate = rootView == nil
        rootView = root
        if needUpdate {
            objectWillChange.send()
        }
    }
}

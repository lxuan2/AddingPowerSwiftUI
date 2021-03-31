//
//  SwiftUIView.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

class APHostingBarButtonItem: UIBarButtonItem {
    private var _rootView: _VariadicView.Children.Element
    private var hostView: UIHostingView<_VariadicView.Children.Element>!
    
    var rootView: _VariadicView.Children.Element {
        get {
            _rootView
        }
        set {
            willUpdateRootView(newValue)
            _rootView = newValue
        }
    }
    
    private func willUpdateRootView(_ newRoot: _VariadicView.Children.Element) {
        if hostView.rootView.id != newRoot.id {
            hostView = UIHostingView(rootView: newRoot)
            customView = hostView
        }
        // more...
    }
    
    private func didInitRootView() {
        hostView = UIHostingView(rootView: _rootView)
        customView = hostView
        // more...
    }
    
    init(rootView: _VariadicView.Children.Element) {
        self._rootView = rootView
        super.init()
        didInitRootView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

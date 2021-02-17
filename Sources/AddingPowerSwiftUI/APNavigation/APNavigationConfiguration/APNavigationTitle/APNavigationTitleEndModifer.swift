//
//  SwiftUIView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

public struct APNavigationTitleEndModifer: ViewModifier {
    @StateObject private var vc = ControllerHolder()
    weak var navigationItem: UINavigationItem?
    
    public func body(content: Content) -> some View {
        content
            .onPreferenceChange(APNavigationTitlePreferenceKey.self) { title in
                if let t = title {
                    if let view = t.view {
                        navigationItem?.title = nil
                        vc.controller = view.makeUIViewController()
                        navigationItem?.titleView = vc.controller!.view
                    } else {
                        navigationItem?.titleView = nil
                        vc.controller = nil
                        navigationItem?.title = t.text
                    }
                } else {
                    navigationItem?.title = nil
                    navigationItem?.titleView = nil
                }
            }
    }
    
    private class ControllerHolder: ObservableObject {
        var controller: UIViewController?
    }
}

extension View {
    public func apNavigationTitleEnd(navigationItem: UINavigationItem?) -> some View {
        modifier(APNavigationTitleEndModifer(navigationItem: navigationItem))
    }
}

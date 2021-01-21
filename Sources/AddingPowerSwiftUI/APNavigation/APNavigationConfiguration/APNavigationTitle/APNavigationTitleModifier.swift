//
//  APNavigationTitleModifier.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

extension View {
    public func apNavigationTitle(_ title: String) -> some View {
        preference(key: APNavigationTitlePreferenceKey.self, value: APNavigationTitle(text: title, view: nil))
    }
    
    public func apNavigationTitle<V>(_ title: () -> V) -> some View where V : View {
        transferView(APNavigationTitlePreferenceKey.self, value: title()) { v in
            APNavigationTitle(text: "", view: v)
        }
    }
}

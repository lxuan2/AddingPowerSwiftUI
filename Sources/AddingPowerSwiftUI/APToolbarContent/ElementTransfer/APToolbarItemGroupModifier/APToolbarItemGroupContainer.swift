//
//  APToolbarItemGroupContainer.swift
//  
//
//  Created by Xuan Li on 3/24/21.
//

import SwiftUI

struct APToolbarItemGroupContainer<Content: View>: _VariadicView_UnaryViewRoot {
    let content: Content
    
    func body(children: _VariadicView.Children) -> some View {
        let list = APBarItemGroupList.getList(children: children)
        return content
            .transformPreference(APToolBarItemPayloadKey.self) {
                list.installGroups(on: &$0)
            }
    }
}

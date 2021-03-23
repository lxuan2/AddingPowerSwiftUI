//
//  APToolbarItemGroupModifier.swift
//  
//
//

import SwiftUI

public struct APToolbarItemGroupModifier<BarContent: APToolbarContent>: ViewModifier {
    var toolBar: BarContent
    
    public func body(content: Content) -> some View {
        _VariadicView.Tree(APToolbarItemGroupContainer(content: content)) {
            BarContent._makeContent(content: toolBar)
        }
    }
    
    init(toolBar: BarContent) {
        self.toolBar = toolBar
    }
}

struct APToolbarItemGroupContainer<Content: View>: _VariadicView_UnaryViewRoot {
    let content: Content
    
    func body(children: _VariadicView.Children) -> some View {
        content
            .transformPreference(APToolBarItemPayloadKey.self) { payload in
                var isIgnored = false
                var ignoredID: AnyHashable!
                ForLoop: for i in 0..<children.count {
                    let element = children[i]
                    if isIgnored {
                        if ignoredID == element.id {
                            continue ForLoop
                        } else {
                            isIgnored = false
                            ignoredID = nil
                        }
                    }
                    let item = element[APBarButtonItemKey.self]!
                    if item.storage.isChanged {
                        item.storage.updateRootView(element)
                        item.storage.isChanged = false
                    }
                    if item.storage.isGroup {
                        isIgnored = true
                        ignoredID = element.id
                    }
                    switch element[APToolbarItemPlacementKey.self] {
                    case .automatic:
                        if payload.topRightBarButtonItems.count < 3 {
                            payload.topRightBarButtonItems.append(item)
                            break
                        }
                        if payload.topLeftBarButtonItems.count < 3 {
                            payload.topLeftBarButtonItems.append(item)
                            break
                        }
                        payload.bottomBarItems.append(item)
                    case .bottomBar:
                        payload.bottomBarItems.append(item)
                    case .cancellationAction:
                        payload.topLeftBarButtonItems.append(item)
                    case .confirmationAction:
                        payload.topRightBarButtonItems.append(item)
                    case .destructiveAction:
                        payload.topRightBarButtonItems.append(item)
                    case .navigation:
                        payload.topRightBarButtonItems.append(item)
                    case .navigationBarLeading:
                        payload.topLeftBarButtonItems.append(item)
                    case .navigationBarTrailing:
                        payload.topRightBarButtonItems.append(item)
                    case .navigationBarBackButton:
                        payload.backBarButtonItem = item
                    case .primaryAction:
                        payload.topRightBarButtonItems.append(item)
                    case .principal:
                        payload.title = item
                    case .status:
                        payload.bottomBarItems.append(item)
                    default:
                        payload.topRightBarButtonItems.append(item)
                    }
                }
            }
    }
}

extension View {
    public func apToolbar<Content>(@APViewBuilder content: () -> Content) -> some View where Content : View {
        modifier(APToolbarItemGroupModifier(toolBar: APToolbarItemGroup(content: content)))
    }
    
    public func apToolbar<Content>(@APToolbarContentBuilder content: () -> Content) -> some View where Content : APToolbarContent {
        modifier(APToolbarItemGroupModifier(toolBar: content()))
    }
}

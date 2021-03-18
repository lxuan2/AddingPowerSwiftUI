//
//  APToolBarItemGroupDestinationModifier.swift
//  
//
//  Created by Xuan Li on 3/17/21.
//

import SwiftUI

struct APToolBarItemGroupDestinationModifier: ViewModifier {
    unowned var navigationItem: UINavigationItem!
    unowned var vc: UIViewController!
    @StateObject private var group = BarItemGroup()
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(APToolbarItemListKey.self) { list in
                var items: [(APUIBarButtonItem, APToolbarItemPlacement.Role)] = []
                var title: (_VariadicView.Children.Element, UUID)?
                list.storage.forEach { (content, placement, rootID) in
                    if placement == .principal {
                        title = (content, rootID)
                    } else {
                        if let item = find(by: content.id) {
                            updateItem(item, content: content, placement: placement)
                            items.append((item, placement.role))
                        } else {
                            items.append((makeItem(content: content, placement: placement), placement.role))
                        }
                    }
                }
                updateTitle(title)
                let (leftBarButtonItems, rightBarButtonItems, bottomBarItems) = distributeItems(items)
                navigationItem.leftBarButtonItems = leftBarButtonItems
                navigationItem.rightBarButtonItems = rightBarButtonItems
                vc.toolbarItems = bottomBarItems
                group.items = leftBarButtonItems + rightBarButtonItems + bottomBarItems
            }
    }
    
    func find(by id: AnyHashable) -> APUIBarButtonItem? {
        group.items.first(where: { $0.id == id })
    }
    
    func updateTitle(_ title: (_VariadicView.Children.Element, UUID)?) {
        if let t = title {
            if let tv = group.titleView {
                if tv.rootID == t.1 {
                    if tv.rootView.id == t.0.id {
                        return
                    }
                    tv.rootView = t.0
                }
            }
            group.titleView = APNavigationTitleView(rootView: t.0)
            group.titleView!.rootID = t.1
            navigationItem.titleView = group.titleView!
        } else if let _ = group.titleView {
            group.titleView = nil
            navigationItem.titleView = nil
        }
    }
    
    func makeItem(content: _VariadicView.Children.Element, placement: APToolbarItemPlacement) -> APUIBarButtonItem {
        fatalError()
        // more...
    }
    
    func updateItem(_ item: APUIBarButtonItem, content: _VariadicView.Children.Element, placement: APToolbarItemPlacement) {
        item.style = placement.style.asUIElement()
        // more...
    }
    
    func distributeItems(_ items: [(APUIBarButtonItem, APToolbarItemPlacement.Role)]) -> ([APUIBarButtonItem], [APUIBarButtonItem], [APUIBarButtonItem]) {
        var leftBarButtonItems: [APUIBarButtonItem] = []
        var rightBarButtonItems: [APUIBarButtonItem] = []
        var bottomBarItems: [APUIBarButtonItem] = []
        var autoItems: [APUIBarButtonItem] = []
        items.forEach { pair in
            switch pair.1 {
            case .automatic:
                autoItems.append(pair.0)
            case .bottomBar:
                bottomBarItems.append(pair.0)
            case .cancellationAction:
                leftBarButtonItems.append(pair.0)
            case .confirmationAction:
                rightBarButtonItems.append(pair.0)
            case .destructiveAction:
                leftBarButtonItems.append(pair.0)
            case .navigation:
                rightBarButtonItems.append(pair.0)
            case .navigationBarLeading:
                leftBarButtonItems.append(pair.0)
            case .navigationBarTrailing:
                rightBarButtonItems.append(pair.0)
            case .primaryAction:
                rightBarButtonItems.append(pair.0)
            case .status:
                bottomBarItems.append(pair.0)
            default:
                rightBarButtonItems.append(pair.0)
            }
        }
        return (leftBarButtonItems, rightBarButtonItems, bottomBarItems)
    }
    
    class BarItemGroup: ObservableObject {
        var items: [APUIBarButtonItem] = []
        var titleView: APNavigationTitleView? = nil
    }
}

class APNavigationTitleView: UIHostingView<_VariadicView.Children.Element> {
    var rootID: UUID!
}

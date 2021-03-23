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
            }
    }
}
    
//    func find(by id: AnyHashable) -> APUIBarButtonItem? {
//        group.items.first(where: { $0.id == id })
//    }
//
//    func updateTitle(_ title: (_VariadicView.Children.Element, UUID)?) {
//        if let t = title {
//            if let tv = group.titleView {
//                if tv.rootID == t.1 {
//                    if tv.rootView.id == t.0.id {
//                        return
//                    }
//                    tv.rootView = t.0
//                }
//            }
//            group.titleView = APNavigationTitleView(rootView: t.0)
//            group.titleView!.rootID = t.1
//            navigationItem.titleView = group.titleView!
//        } else if let _ = group.titleView {
//            group.titleView = nil
//            navigationItem.titleView = nil
//        }
//    }
//
//    func makeItem(content: _VariadicView.Children.Element, placement: APToolbarItemPlacement, rootID: UUID) -> APUIBarButtonItem {
//        fatalError()
//        // more...
//    }
//
//    func updateItem(_ item: APUIBarButtonItem, content: _VariadicView.Children.Element, placement: APToolbarItemPlacement, rootID: UUID) {
////        item.style = placement.style.asUIElement()x
//        // more...
//    }
//
//    func distributeItems(_ items: [(APUIBarButtonItem, APToolbarItemPlacement.Role)]) -> ([APUIBarButtonItem], [APUIBarButtonItem], [APUIBarButtonItem]) {
//        var leftBarButtonItems: [APUIBarButtonItem] = []
//        var rightBarButtonItems: [APUIBarButtonItem] = []
//        var bottomBarItems: [APUIBarButtonItem] = []
//        var autoItems: [APUIBarButtonItem] = []
//        items.forEach { pair in
//            switch pair.1 {
//            case .automatic:
//                autoItems.append(pair.0)
//            case .bottomBar:
//                bottomBarItems.append(pair.0)
//            case .cancellationAction:
//                leftBarButtonItems.append(pair.0)
//            case .confirmationAction:
//                rightBarButtonItems.append(pair.0)
//            case .destructiveAction:
//                leftBarButtonItems.append(pair.0)
//            case .navigation:
//                rightBarButtonItems.append(pair.0)
//            case .navigationBarLeading:
//                leftBarButtonItems.append(pair.0)
//            case .navigationBarTrailing:
//                rightBarButtonItems.append(pair.0)
//            case .primaryAction:
//                rightBarButtonItems.append(pair.0)
//            case .status:
//                bottomBarItems.append(pair.0)
//            default:
//                rightBarButtonItems.append(pair.0)
//            }
//        }
//        if distributeAutoItems(&autoItems, into: &rightBarButtonItems, limit: 3) {
//            return (leftBarButtonItems, rightBarButtonItems, bottomBarItems)
//        }
//
//        if distributeAutoItems(&autoItems, into: &leftBarButtonItems, limit: 2) {
//            return (leftBarButtonItems, rightBarButtonItems, bottomBarItems)
//        }
//        bottomBarItems.append(contentsOf: autoItems)
//        return (leftBarButtonItems, rightBarButtonItems, bottomBarItems)
//    }
//
//    func distributeAutoItems(_ autoItems: inout [APUIBarButtonItem], into container: inout [APUIBarButtonItem], limit: Int) -> Bool {
//        if autoItems.count > 0 {
//            let rrest = 2 - container.count
//            if rrest > 0 {
//                if rrest > autoItems.count {
//                    container.append(contentsOf: autoItems)
//                    autoItems.removeAll()
//                    return true
//                }
//                container.append(contentsOf: Array(autoItems[0..<rrest]))
//                autoItems.removeSubrange(0..<rrest)
//            }
//            return autoItems.isEmpty
//        }
//        return true
//    }
//
//    class BarItemGroup: ObservableObject {
//        var items: [APUIBarButtonItem] = []
//        var titleView: APNavigationTitleView? = nil
//    }
//}

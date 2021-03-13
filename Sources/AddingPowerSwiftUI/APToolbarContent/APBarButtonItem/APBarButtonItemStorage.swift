//
//  APBarButtonItemStorage.swift
//  
//
//

import SwiftUI

public class APBarButtonItemStorage: Equatable, ObservableObject {
    @usableFromInline
    let id: UUID = UUID()
    var itemStyle: APToolbarItemPlacement.Style = .plain
    var itemID: AnyHashable? = nil
    var item: Item = .none
    private weak var subscriber: APUIBarButtonItem? = nil
    
    init() {}
    
    @usableFromInline
    func getUIBarButtonItem() -> UIBarButtonItem {
        if let s = subscriber {
            return s
        }
        let s = APUIBarButtonItem()
        APBarButtonItemStorage.initItem(uiBarItem: s, with: item, style: itemStyle)
        subscriber = s
        return s
    }
    
    func updateItemStyle(_ style: APToolbarItemPlacement.Style) {
        if itemStyle != style, let s = subscriber {
            s.style = style.asUIElement()
        }
        itemStyle = style
    }
    
    func updateContent(_ content: _VariadicView.Children) {
        if let itmid = itemID {
            if content.contains(where: { $0.id == itmid }) {
                return
            } else {
                resetSubscriber()
                let first = content[0]
                itemID = first.id
                if let image = first[APImageTraitKey.self] {
                    item = .customView(first)
                } else {
                    item = .customView(first)
                }
                if let s = subscriber {
                    Self.initItem(uiBarItem: s, with: item, style: itemStyle)
                }
                return
            }
        }
        
        let first = content[0]
        itemID = first.id
        if let image = first[APImageTraitKey.self] {
            item = .customView(first)
        } else {
            item = .customView(first)
        }
        updateSubscriber()
    }
    
    public static func == (lhs: APBarButtonItemStorage, rhs: APBarButtonItemStorage) -> Bool {
        lhs.id == rhs.id
    }
}

extension APBarButtonItemStorage {
    enum Item {
        case buttonImage(APImage?, () -> Void)
        case buttonTitle(String?, () -> Void)
        case customView(_VariadicView.Children.Element)
        case none
    }
    
    private func updateSubscriber() {
        if let s = subscriber {
            switch item {
            case .buttonImage(let image, let action):
                s.image = image?.asUIImage()
                s.style = itemStyle.asUIElement()
                s._actionHandler = action
            case .buttonTitle(let title, let action):
                s.image = nil
                s.title = title
                s.style = itemStyle.asUIElement()
                s._actionHandler = action
            case .customView(let view):
                s.host?.rootView = view
            case .none:
                break
            }
        }
    }
    
    private func resetSubscriber() {
        if let s = subscriber {
            switch item {
            case .buttonImage(_, _):
                s.image = nil
                s.style = .plain
                s._actionHandler = nil
            case .buttonTitle(_, _):
                s.title = nil
                s.style = .plain
                s._actionHandler = nil
            case .customView(_):
                s.host = nil
            case .none:
                break
            }
        }
    }
    
    static private func initItem(uiBarItem: APUIBarButtonItem, with item: Item, style: APToolbarItemPlacement.Style) {
        switch item {
        case .customView(let view):
            let vc = UIHostingController(rootView: view)
            vc.view.backgroundColor = .clear
            uiBarItem.customView = vc.view
            uiBarItem.host = vc
        case .buttonImage(let image, let action):
            uiBarItem.image = image?.asUIImage()
            uiBarItem.style = style.asUIElement()
            uiBarItem._actionHandler = action
            uiBarItem.target = uiBarItem
            uiBarItem.action = #selector(uiBarItem.actionHandler)
        case .buttonTitle(let title, let action):
            uiBarItem.title = title
            uiBarItem.style = style.asUIElement()
            uiBarItem._actionHandler = action
            uiBarItem.target = uiBarItem
            uiBarItem.action = #selector(uiBarItem.actionHandler)
        case .none:
            break
        }
    }
}

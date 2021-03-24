//
//  APBarItemGroupList.swift
//  
//
//  Created by Xuan Li on 3/24/21.
//

import SwiftUI

struct APBarItemGroupList {
    private enum ItemGroup {
        case payload(APBarButtonItemPayload)
        case auto([APBarButtonItem])
    }
    
    private var storage: [ItemGroup] = []
    private var currentPayload: APBarButtonItemPayload? = nil
    private var currentAuto: [APBarButtonItem]? = nil
    
    mutating func addGroup(_ group: [APBarButtonItem], placement: APToolbarItemPlacement) {
        if currentPayload != nil {
            if placement == .automatic {
                storage.append(.payload(currentPayload!))
                currentPayload = nil
                return
            }
            appendGroupToPayload(group: group, placement: placement, payload: &currentPayload!)
            return
        } else if currentAuto != nil {
            if placement != .automatic {
                storage.append(.auto(currentAuto!))
                currentAuto = nil
                return
            }
            currentAuto!.append(contentsOf: group)
            return
        } else if placement == .automatic {
            currentAuto = group
            return
        }
        currentPayload = APBarButtonItemPayload()
        appendGroupToPayload(group: group, placement: placement, payload: &currentPayload!)
    }
    
    mutating func finishAdding() {
        if currentPayload != nil {
            storage.append(.payload(currentPayload!))
            currentPayload = nil
        } else if currentAuto != nil {
            storage.append(.auto(currentAuto!))
            currentAuto = nil
        }
    }
    
    func installGroups(on payload: inout APBarButtonItemPayload) {
        storage.forEach {
            switch $0 {
            case .payload(let p):
                payload.concat(p)
            case .auto(let a):
                let count = a.count
                if payload.topRightBarButtonItems.count + count < 3 {
                    payload.topRightBarButtonItems.append(contentsOf: a)
                } else if (payload.topLeftBarButtonItems.count + count < 2) {
                    payload.topLeftBarButtonItems.append(contentsOf: a)
                } else {
                    payload.bottomBarItems.append(contentsOf: a)
                }
            }
        }
    }
    
    static func getList(children: _VariadicView.Children) -> APBarItemGroupList {
        var list = APBarItemGroupList()
        var currentStorage: APBarButtonItemStorageBase?
        var currentPlacement: APToolbarItemPlacement = .automatic
        var group: [_VariadicView.Children.Element] = []
        for i in 0..<children.count {
            let element = children[i]
            let storage = element[APBarButtonItemStorageBoxKey.self]!.storage
            if storage == currentStorage {
                group.append(element)
            } else {
                if let s = currentStorage {
                    list.addGroup(s.getItemGroup(group), placement: currentPlacement)
                }
                group = [element]
                currentStorage = storage
                currentPlacement = element[APToolbarItemPlacementKey.self]
            }
        }
        if !group.isEmpty, let s = currentStorage {
            list.addGroup(s.getItemGroup(group), placement: currentPlacement)
        }
        list.finishAdding()
        return list
    }
    
    private func appendGroupToPayload(group: [APBarButtonItem], placement: APToolbarItemPlacement, payload: inout APBarButtonItemPayload) {
        switch placement {
        case .bottomBar:
            payload.bottomBarItems.append(contentsOf: group)
        case .cancellationAction:
            payload.topLeftBarButtonItems.append(contentsOf: group)
        case .confirmationAction:
            payload.topRightBarButtonItems.append(contentsOf: group)
        case .destructiveAction:
            payload.topRightBarButtonItems.append(contentsOf: group)
        case .navigation:
            payload.topRightBarButtonItems.append(contentsOf: group)
        case .navigationBarLeading:
            payload.topLeftBarButtonItems.append(contentsOf: group)
        case .navigationBarTrailing:
            payload.topRightBarButtonItems.append(contentsOf: group)
        case .navigationBarBackButton:
            payload.backBarButtonItem = group[0]
        case .primaryAction:
            payload.topRightBarButtonItems.append(contentsOf: group)
        case .principal:
            payload.title = group[0]
        case .status:
            payload.bottomBarItems.append(contentsOf: group)
        default:
            payload.topRightBarButtonItems.append(contentsOf: group)
        }
    }
}

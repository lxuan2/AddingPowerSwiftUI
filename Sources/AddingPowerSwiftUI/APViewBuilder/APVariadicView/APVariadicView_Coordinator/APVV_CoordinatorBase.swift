//
//  APVVCoordinatorBase.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class CoordinatorBase: ObservableObject {
        
        public func rootChange(_ newStorage: [APVariadicView]) {
            fatalError("CoordinatorBase: not implemented")
        }
        
        public func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            fatalError("CoordinatorBase: not implemented")
        }
        
        public func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            fatalError("CoordinatorBase: not implemented")
        }
    }
}

public protocol APVariadicView_CoordinatorProtocol: APVariadicView.CoordinatorBase {
    associatedtype Configuration
    func toConfiguration() -> Configuration
}

extension Array {
    mutating func removeFirst(where: (Element) -> Bool) {
        if let index = firstIndex(where: `where`) {
            remove(at: index)
        }
    }
}

extension Array where Element: Equatable {
    func contains(_ subarray: [Element]) -> Bool {
        var found = 0
        for element in self where found < subarray.count {
            if element == subarray[found] {
                found += 1
            } else {
                found = element == subarray[0] ? 1 : 0
            }
        }
        
        return found == subarray.count
    }
}

extension Array where Element == APPath {
    func find(in viewRoot: APVariadicView_MultiViewRoot) -> APVariadicView? {
        if viewRoot.location!.count > self.count {
            return nil
        }
        for (i, item) in viewRoot.location!.enumerated() {
            if item != self[i] {
                return nil
            }
        }
        var root = viewRoot
        let rest = Array(self[viewRoot.location!.count...])
        for (index, i) in rest.enumerated() {
            if let newRoot = root.getViewRoot(path: i) {
                switch newRoot {
                case .unary(_):
                    if index == rest.count - 1 {
                        return newRoot
                    } else {
                        return nil
                    }
                case .multi(let multi):
                    root = multi
                }
            } else {
                return nil
            }
        }
        return .multi(root)
    }
    
    func findView(in viewRoot: APVariadicView_MultiViewRoot) -> APAnyUniqueView? {
        if viewRoot.location!.count > self.count {
            return nil
        }
        for (i, item) in viewRoot.location!.enumerated() {
            if item != self[i] {
                return nil
            }
        }
        var root = viewRoot
        let rest = Array(self[viewRoot.location!.count...])
        for (index, i) in rest.enumerated() {
            if let newRoot = root.getViewRoot(path: i) {
                switch newRoot {
                case .unary(let nv):
                    if index == rest.count - 1 {
                        return nv
                    } else {
                        return nil
                    }
                case .multi(let multi):
                    root = multi
                }
            } else {
                return nil
            }
        }
        return nil
    }
}

extension Array where Element == APVariadicView {
    public func getAmount() -> Int {
        var amount = 0
        for i in self {
            switch i {
            case .unary(_):
                amount += 1
            case .multi(let newPoint):
                amount += newPoint.getAmount()
            }
        }
        return amount
    }
}

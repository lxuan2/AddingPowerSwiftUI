//
//  APVV_CoordinatorBase.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class CoordinatorBase: ObservableObject {
        public var viewRoot = APVariadicView_MultiViewRoot()
        public func replace(newStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, env: APPathEnvironment) {
            subRoot.storage = newStorage
            subRoot.env = env
        }
        
        public func update(changedStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, with ids: [AnyHashable]) {
            subRoot.storage = changedStorage
            subRoot.ids = ids
        }
        
        public func initRoot(with initStorage: [APVariadicView]) {
            viewRoot.storage = initStorage
        }
        
        public init() {}
    }
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

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
        
        public func viewRootChange(_ viewRoot: APVariadicView_MultiViewRoot, _ changedStorage: [APVariadicView]) {
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

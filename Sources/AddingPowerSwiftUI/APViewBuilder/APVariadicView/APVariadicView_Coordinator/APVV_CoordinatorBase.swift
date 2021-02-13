//
//  APVV_CoordinatorBase.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class CoordinatorBase: ObservableObject {
        public var root = APVariadicView_Root()
        public func replace(viewRoot: [APVariadicView], in subRoot: APVariadicView_Root, atrribute: APPath.Attribute) {
            subRoot.viewRoot = viewRoot
            subRoot.pathAttribute = atrribute
        }
        
        public func initRoot(with viewRoot: [APVariadicView]) {
            root.viewRoot = viewRoot
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

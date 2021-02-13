//
//  APVariadicView.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public enum APVariadicView: Equatable {
    public typealias UnaryViewRoot = APAnySynView
    public typealias MultiViewRoot = APVariadicView_MultiViewHost
    case unary(UnaryViewRoot)
    case multi(MultiViewRoot)
}

extension APVariadicView {
    public class Coordinator: ObservableObject {
        public var delegate: APVariadicView_Delegate
        public var root: APVariadicView_MultiViewHost
        public var viewList: [APAnySynView]
        
        public func updates(viewRoot: [APVariadicView], in subRoot: APVariadicView_MultiViewHost, atrribute: APPath.Attribute) {
            if let loc = subRoot.location {
                let views = initTree(viewRoot, at: loc, atrribute: atrribute)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + subRoot.getAmount()
                delegate.viewList(viewList, willReplace: range, with: views)
//                if range.lowerBound == viewList.count
                viewList.replaceSubrange(range, with: views)
//                viewList.removeSubrange(range)
//                viewList.insert(contentsOf: views, at: range.lowerBound)
                delegate.viewList(viewList, didReplace: range, with: views)
            }
            subRoot.viewRoot = viewRoot
            subRoot.pathAttribute = atrribute
        }
        
        public func initRoot(with viewRoot: [APVariadicView]) {
            let views = initTree(viewRoot, at: [], atrribute: .any)
            delegate.viewList(viewList, willReplace: 0..<0, with: views)
            viewList.replaceSubrange(0..<0, with: views)
            delegate.viewList(viewList, didReplace: 0..<0, with: views)
            root.viewRoot = viewRoot
        }
        
        public func initTree(_ views: [APVariadicView], at location: [APPath], atrribute: APPath.Attribute) -> [APAnySynView] {
            var newViews: [APAnySynView] = []
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(let nv):
                    newViews.append(nv)
                case .multi(let multiroot):
                    let loc = location + [APPath(direction: i, attribute: atrribute)]
                    multiroot.location = loc
                    newViews.append(contentsOf: initTree(multiroot.viewRoot, at: loc, atrribute: multiroot.pathAttribute))
                }
            }
            return newViews
        }
        
        public init(delegate: APVariadicView_Delegate) {
            self.delegate = delegate
            self.root = APVariadicView_MultiViewHost()
            self.viewList = []
        }
    }
}

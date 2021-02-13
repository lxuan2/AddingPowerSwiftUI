//
//  APVV_Coordinator.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class Coordinator: CoordinatorBase {
        public var delegate: APVariadicView_Delegate
        public var viewList: [APAnySynView]
        public var cache: [UUID]? = []
        
        public override func replace(viewRoot: [APVariadicView], in subRoot: APVariadicView_Root, atrribute: APPath.Attribute) {
            if let loc = subRoot.location {
                let views = initBranch(viewRoot, at: loc, atrribute: atrribute)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + subRoot.getAmount()
                let isInited = cache == nil
                if isInited {
                    delegate.viewList(viewList, willReplace: range, with: views)
                }
                viewList.replaceSubrange(range, with: views)
                if isInited {
                    delegate.viewList(viewList, didReplace: range, with: views)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == subRoot.id })
                    if cache!.isEmpty {
                        delegate.initial(viewList)
                        cache = nil
                    }
                }
            }
            subRoot.viewRoot = viewRoot
            subRoot.pathAttribute = atrribute
        }
        
        public override func initRoot(with viewRoot: [APVariadicView]) {
            viewList = initBranch(viewRoot, at: [], atrribute: .any)
            root.viewRoot = viewRoot
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], atrribute: APPath.Attribute) -> [APAnySynView] {
            var newViews: [APAnySynView] = []
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(let nv):
                    newViews.append(nv)
                case .multi(let multiroot):
                    if multiroot.location == nil {
                        let loc = location + [APPath(direction: i, attribute: atrribute)]
                        if cache != nil {
                            cache!.append(multiroot.id)
                        }
                        multiroot.location = loc
                    }
                    newViews.append(contentsOf: initBranch(multiroot.viewRoot, at: multiroot.location!, atrribute: multiroot.pathAttribute))
                }
            }
            return newViews
        }
        
        public init(delegate: APVariadicView_Delegate) {
            self.delegate = delegate
            self.viewList = []
        }
    }
}

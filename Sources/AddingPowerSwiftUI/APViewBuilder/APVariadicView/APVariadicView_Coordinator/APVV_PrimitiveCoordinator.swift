//
//  APVV_PrimitiveCoordinator.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class PrimitiveCoordinator: CoordinatorBase {
        public var delegate: APVariadicView_PrimitiveDelegate
        public var cache: [UUID]? = []
        
        public override func replace(viewRoot: [APVariadicView], in subRoot: APVariadicView_Root, atrribute: APPath.Attribute) {
            if let loc = subRoot.location {
                initBranch(viewRoot, at: loc, atrribute: atrribute)
                let isInited = cache == nil
                if isInited {
                    delegate.subRoot(subRoot: subRoot, willUpdate: viewRoot, in: root)
                }
                subRoot.viewRoot = viewRoot
                subRoot.pathAttribute = atrribute
                if isInited {
                    delegate.subRoot(subRoot: subRoot, didUpdate: viewRoot, in: root)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == subRoot.id })
                    if cache!.isEmpty {
                        delegate.initial(root)
                        cache = nil
                    }
                }
            } else {
                subRoot.viewRoot = viewRoot
                subRoot.pathAttribute = atrribute
            }
        }
        
        public override func initRoot(with viewRoot: [APVariadicView]) {
            initBranch(viewRoot, at: [], atrribute: .any)
            root.viewRoot = viewRoot
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], atrribute: APPath.Attribute) {
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(_):
                    break
                case .multi(let multiroot):
                    if multiroot.location == nil {
                        let loc = location + [APPath(direction: i, attribute: atrribute)]
                        if cache != nil {
                            cache!.append(multiroot.id)
                        }
                        multiroot.location = loc
                    }
                    initBranch(multiroot.viewRoot, at: multiroot.location!, atrribute: multiroot.pathAttribute)
                }
            }
        }
        
        public init(delegate: APVariadicView_PrimitiveDelegate) {
            self.delegate = delegate
        }
    }
}

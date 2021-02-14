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
        
        public override func replace(newStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, env: APPathEnvironment) {
            if let loc = subRoot.location {
                let views = initBranch(newStorage, at: loc, env: env)
                let startIndex = viewRoot.getIndex(in: loc)
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
            subRoot.storage = newStorage
            subRoot.env = env
        }
        
        public override func update(changedStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, with ids: [AnyHashable]) {
            if let loc = subRoot.location {
                let views = initBranch(changedStorage, at: loc, env: subRoot.env)
                let startIndex = viewRoot.getIndex(in: loc)
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
            subRoot.storage = changedStorage
            subRoot.ids = ids
        }
        
        public override func initRoot(with initStorage: [APVariadicView]) {
            viewList = initBranch(initStorage, at: [], env: .none)
            viewRoot.storage = initStorage
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], env: APPathEnvironment) -> [APAnySynView] {
            var newViews: [APAnySynView] = []
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(let nv):
                    newViews.append(nv)
                case .multi(let multiroot):
                    if multiroot.location == nil {
                        if cache != nil {
                            cache!.append(multiroot.id)
                        }
                        multiroot.location = location.resolve(in: env, with: i)
                    }
                    newViews.append(contentsOf: initBranch(multiroot.storage, at: multiroot.location!, env: multiroot.env))
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

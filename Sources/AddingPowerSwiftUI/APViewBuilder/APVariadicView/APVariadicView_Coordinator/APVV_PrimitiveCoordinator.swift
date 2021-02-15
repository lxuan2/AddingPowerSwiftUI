//
//  APVV_PrimitiveCoordinator.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

extension APVariadicView {
    public class PrimitiveCoordinator: CoordinatorBase {
        public var delegate: APVariadicView_PrimitiveDelegate?
        public var cache: [UUID]? = []
        
        public override func replace(newStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, env: APPathEnvironment) {
            if let loc = subRoot.location {
                initBranch(newStorage, at: loc, env: env)
                let isInited = cache == nil
                if isInited {
                    delegate?.subRoot(subRoot: subRoot, willUpdate: newStorage, in: viewRoot)
                }
                subRoot.storage = newStorage
                subRoot.env = env
                if isInited {
                    delegate?.subRoot(subRoot: subRoot, didUpdate: newStorage, in: viewRoot)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == subRoot.id })
                    if cache!.isEmpty {
                        delegate?.initial(viewRoot)
                        cache = nil
                    }
                }
            } else {
                subRoot.storage = newStorage
                subRoot.env = env
            }
        }
        
        public override func update(changedStorage: [APVariadicView], in subRoot: APVariadicView_MultiViewRoot, with ids: [AnyHashable]) {
            if let loc = subRoot.location {
                initBranch(changedStorage, at: loc, env: subRoot.env)
                let isInited = cache == nil
                if isInited {
                    delegate?.subRoot(subRoot: subRoot, willUpdate: changedStorage, in: viewRoot)
                }
                subRoot.storage = changedStorage
                subRoot.ids = ids
                if isInited {
                    delegate?.subRoot(subRoot: subRoot, didUpdate: changedStorage, in: viewRoot)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == subRoot.id })
                    if cache!.isEmpty {
                        delegate?.initial(viewRoot)
                        cache = nil
                    }
                }
            } else {
                subRoot.storage = changedStorage
                subRoot.ids = ids
            }
        }
        
        public override func initRoot(with initStorage: [APVariadicView]) {
            initBranch(initStorage, at: [], env: .none)
            viewRoot.storage = initStorage
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], env: APPathEnvironment) {
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(_):
                    break
                case .multi(let multiroot):
                    if multiroot.location == nil {
                        if cache != nil {
                            cache!.append(multiroot.id)
                        }
                        multiroot.location = location.resolve(in: env, with: i)
                    }
                    initBranch(multiroot.storage, at: multiroot.location!, env: multiroot.env)
                }
            }
        }
        
        public init(delegate: APVariadicView_PrimitiveDelegate?) {
            self.delegate = delegate
        }
    }
}

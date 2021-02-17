//
//  APVV_PrimitiveCoordinator.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI
import Combine

extension APVariadicView {
    public class PrimitiveCoordinator: CoordinatorBase, APVariadicView_CoordinatorProtocol {
        public override init() {}
        
        public var cache: [UUID]? = []
        public let root = APVariadicView_MultiViewRoot(location: [])
        public let rootInit = PassthroughSubject<Void, Never>()
        public let viewRootChange = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView]), Never>()
        public let viewRootReplace = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>()
        public let viewRootModification = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>()
        
        public func toConfiguration() -> APVariadicViewPrimitiveConfiguration {
            return APVariadicViewPrimitiveConfiguration(root: self.root,
                                                        rootInit: self.rootInit.eraseToAnyPublisher(),
                                                        viewRootChange: self.viewRootChange.eraseToAnyPublisher(),
                                                        viewRootReplace: self.viewRootReplace.eraseToAnyPublisher(),
                                                        viewRootModification: self.viewRootModification.eraseToAnyPublisher())
        }
        
        public override func rootChange(_ newStorage: [APVariadicView]) {
            if cache == nil {
                viewRootChange.send((root, newStorage))
                return
            }
            initBranch(newStorage, at: [], env: .none)
            root.storage = newStorage
            if cache!.isEmpty {
                cache = nil
                rootInit.send()
            }
        }
        
        public override func viewRootChange(_ viewRoot: APVariadicView_MultiViewRoot, _ changedStorage: [APVariadicView]) {
            if let loc = viewRoot.location {
                initBranch(changedStorage, at: loc, env: viewRoot.env)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        rootInit.send()
                    }
                    return viewRoot.storage = changedStorage
                }
                return viewRootChange.send((viewRoot, changedStorage))
            }
            viewRoot.storage = changedStorage
        }
        
        public override func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            if let loc = viewRoot.location {
                initBranch(newStorage, at: loc, env: env)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        rootInit.send()
                    }
                    viewRoot.storage = newStorage
                    viewRoot.env = env
                    return
                }
                return viewRootReplace.send((viewRoot, newStorage, env))
            }
            viewRoot.storage = newStorage
            viewRoot.env = env
        }
        
        public override func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            if let loc = viewRoot.location {
                // fix me
                initBranch(modifiedStorage, at: loc, env: .identifiable, ids: ids)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        rootInit.send()
                    }
                    viewRoot.storage = modifiedStorage
                    viewRoot.ids = ids
                    return
                }
                return viewRootModification.send((viewRoot, modifiedStorage, ids))
            }
            viewRoot.storage = modifiedStorage
            viewRoot.ids = ids
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], env: APPathEnvironment, ids: [AnyHashable] = []) {
            let vr = APVariadicView_MultiViewRoot(storage: views, id: UUID(), location: location, env: env, ids: ids)
            initBranch(vr)
        }
        
        public func initBranch(_ viewRoot: APVariadicView_MultiViewRoot) {
            for (i, item) in viewRoot.storage.enumerated() {
                switch item {
                case .unary(_):
                    break
                case .multi(let multiRoot):
                    if multiRoot.location == nil {
                        if cache != nil {
                            cache!.append(multiRoot.id)
                        }
                        multiRoot.location = viewRoot.getPathForChild(at: i)
                    }
                    initBranch(multiRoot)
                }
            }
        }
    }
}

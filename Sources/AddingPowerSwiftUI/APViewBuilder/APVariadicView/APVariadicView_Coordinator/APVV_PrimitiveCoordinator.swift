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
            root.storage = newStorage
            initBranch(root)
            if cache!.isEmpty {
                cache = nil
                rootInit.send()
            }
        }
        
        public override func viewRootChange(_ viewRoot: APVariadicView_MultiViewRoot, _ changedStorage: [APVariadicView]) {
            let oldStorage = viewRoot.storage
            viewRoot.storage = changedStorage
            if viewRoot.location == nil {
                return
            }
            initBranch(viewRoot)
            if cache != nil {
                cache!.removeFirst(where: { $0 == viewRoot.id })
                if cache!.isEmpty {
                    cache = nil
                    rootInit.send()
                }
                return
            }
            viewRootChange.send((viewRoot, oldStorage))
        }
        
        public override func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            let oldStorage = viewRoot.storage
            let oldEnv = viewRoot.env
            viewRoot.storage = newStorage
            viewRoot.env = env
            if viewRoot.location == nil {
                return
            }
            initBranch(viewRoot)
            if cache != nil {
                cache!.removeFirst(where: { $0 == viewRoot.id })
                if cache!.isEmpty {
                    cache = nil
                    rootInit.send()
                }
                return
            }
            viewRootReplace.send((viewRoot, oldStorage, oldEnv))
        }
        
        public override func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            let oldStorage = viewRoot.storage
            let oldIds = viewRoot.ids
            viewRoot.storage = modifiedStorage
            viewRoot.ids = ids
            if viewRoot.location == nil {
                return
            }
            initBranch(viewRoot)
            if cache != nil {
                cache!.removeFirst(where: { $0 == viewRoot.id })
                if cache!.isEmpty {
                    cache = nil
                    rootInit.send()
                }
                return
            }
            viewRootModification.send((viewRoot, oldStorage, oldIds))
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

//
//  APVV_PrimitiveCoordinator.swift
//  
//
//

import SwiftUI
import Combine

extension APVariadicView {
    public class PrimitiveCoordinator: CoordinatorBase, APVariadicView_CoordinatorProtocol {
        public override init() {}
        
        public var cache: [UUID]? = []
        public let root = APVariadicView_MultiViewRoot(location: [])
        public let rootInit = PassthroughSubject<Void, Never>()
        public let viewRootChange = PassthroughSubject<(APVariadicView_MultiViewRoot, [Int], [APVariadicView]), Never>()
        public let viewRootReplace = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>()
        public let viewRootModification = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>()
        
        public func toConfiguration() -> APVariadicViewPrimitiveConfiguration {
            APVariadicViewPrimitiveConfiguration(root: self.root,
                                                 rootInit: self.rootInit.eraseToAnyPublisher(),
                                                 viewRootReplace: self.viewRootReplace.eraseToAnyPublisher(),
                                                 viewRootModification: self.viewRootModification.eraseToAnyPublisher())
        }
        
        public override func rootChange(_ newStorage: [APVariadicView]) {
            if cache == nil {
                viewRootReplace(root, newStorage, root.env)
                return
            }
            root.storage = newStorage
            root.location = []
            initBranch(root)
            if cache!.isEmpty {
                cache = nil
                rootInit.send()
            }
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
        
        public func findDifference(viewRoot: APVariadicView_MultiViewRoot, changedStorage: [APVariadicView]) -> [Int] {
            var idxSet: [Int] = []
            for (i, item) in changedStorage.enumerated() {
                if viewRoot.storage[i] != item {
                    idxSet.append(i)
                    switch item {
                    case .unary(_):
                        viewRoot.storage[i] = item
                    case .multi(let multi):
                        initBranch(multi)
                        viewRoot.storage[i] = .multi(multi)
                    }
                }
            }
            return idxSet
        }
    }
}

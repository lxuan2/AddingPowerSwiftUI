//
//  APVV_Coordinator.swift
//  
//
//

import SwiftUI
import Combine

extension APVariadicView {
    public class Coordinator: CoordinatorBase, APVariadicView_CoordinatorProtocol {
        public override init() {}
        
        public var cache: [UUID]? = []
        public var viewList: [APAnyUniqueView] = []
        public let root = APVariadicView_MultiViewRoot()
        public let onInit = PassthroughSubject<[APAnyUniqueView], Never>()
        public let onReplace = PassthroughSubject<([APAnyUniqueView], Range<Int>, [APAnyUniqueView]), Never>()
        public let onModification = PassthroughSubject<([APAnyUniqueView], Range<Int>, [APAnyUniqueView]), Never>()
        
        public func toConfiguration() -> APVariadicViewConfiguration {
            APVariadicViewConfiguration(
                onInit: self.onInit.eraseToAnyPublisher(),
                onReplace: self.onReplace.eraseToAnyPublisher(),
                onModification: self.onModification.eraseToAnyPublisher())
        }
        
        public override func rootChange(_ newStorage: [APVariadicView]) {
            if cache == nil {
                viewRootReplace(root, newStorage, root.env)
                return
            }
            root.storage = newStorage
            root.location = []
            viewList = initBranch(root)
            if cache!.isEmpty {
                cache = nil
                onInit.send(viewList)
            }
        }
        
        public override func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            let oldStorage = viewRoot.storage
            viewRoot.storage = newStorage
            viewRoot.env = env
            if let loc = viewRoot.location {
                let views = initBranch(viewRoot)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + oldStorage.getAmount()
                let vl = viewList
                viewList.replaceSubrange(range, with: views)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        onInit.send(viewList)
                    }
                } else {
                    onReplace.send((vl, range, views))
                }
            }
        }
        
        public override func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            let oldStorage = viewRoot.storage
            viewRoot.storage = modifiedStorage
            viewRoot.ids = ids
            if let loc = viewRoot.location {
                let views = initBranch(viewRoot)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + oldStorage.getAmount()
                let vl = viewList
                viewList.replaceSubrange(range, with: views)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        onInit.send(viewList)
                    }
                } else {
                    onModification.send((vl, range, views))
                }
            }
        }
        
        public func initBranch(_ viewRoot: APVariadicView_MultiViewRoot) -> [APAnyUniqueView] {
            var newViews: [APAnyUniqueView] = []
            for (i, item) in viewRoot.storage.enumerated() {
                switch item {
                case .unary(let nv):
                    newViews.append(nv)
                case .multi(let multiRoot):
                    if multiRoot.location == nil {
                        if cache != nil {
                            cache!.append(multiRoot.id)
                        }
                        multiRoot.location = viewRoot.getPathForChild(at: i)
                    }
                    newViews.append(contentsOf: initBranch(multiRoot))
                }
            }
            return newViews
        }
    }
}

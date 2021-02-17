//
//  APVV_Coordinator.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI
import Combine

extension APVariadicView {
    public class Coordinator: CoordinatorBase, APVariadicView_CoordinatorProtocol {
        public override init() {}
        
        public var cache: [UUID]? = []
        public var viewList: [APAnySynView] = []
        public let root = APVariadicView_MultiViewRoot()
        public let onInit = PassthroughSubject<[APAnySynView], Never>()
        public let onChange = PassthroughSubject<([APAnySynView], Range<Int>, [APAnySynView]), Never>()
        public let onReplace = PassthroughSubject<([APAnySynView], Range<Int>, [APAnySynView]), Never>()
        public let onModification = PassthroughSubject<([APAnySynView], Range<Int>, [APAnySynView]), Never>()
        
        public func toConfiguration() -> APVariadicViewConfiguration {
            APVariadicViewConfiguration(
                onInit: self.onInit.eraseToAnyPublisher(),
                onChange: self.onChange.eraseToAnyPublisher(),
                onReplace: self.onReplace.eraseToAnyPublisher(),
                onModification: self.onModification.eraseToAnyPublisher())
        }
        
        public override func rootChange(_ newStorage: [APVariadicView]) {
            if cache == nil {
                viewRootChange(root, newStorage)
                return
            }
            viewList = initBranch(newStorage, at: [], env: .none)
            root.storage = newStorage
            if cache!.isEmpty {
                cache = nil
                onInit.send(viewList)
            }
        }
        
        public override func viewRootChange(_ viewRoot: APVariadicView_MultiViewRoot, _ changedStorage: [APVariadicView]) {
            if let loc = viewRoot.location {
                let views = initBranch(changedStorage, at: loc, env: viewRoot.env)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + viewRoot.getAmount()
                let vl = viewList
                viewList.replaceSubrange(range, with: views)
                if cache != nil {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
                        cache = nil
                        onInit.send(viewList)
                    }
                } else {
                    onChange.send((vl, range, views))
                }
            }
            viewRoot.storage = changedStorage
        }
        
        public override func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            if let loc = viewRoot.location {
                let views = initBranch(newStorage, at: loc, env: env)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + viewRoot.getAmount()
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
            viewRoot.storage = newStorage
            viewRoot.env = env
        }
        
        public override func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            if let loc = viewRoot.location {
                // fix me
                let views = initBranch(modifiedStorage, at: loc, env: .identifiable, ids: ids)
                let startIndex = root.getIndex(in: loc)
                let range = startIndex..<startIndex + viewRoot.getAmount()
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
            viewRoot.storage = modifiedStorage
            viewRoot.ids = ids
        }
        
        public func initBranch(_ views: [APVariadicView], at location: [APPath], env: APPathEnvironment, ids: [AnyHashable] = []) -> [APAnySynView] {
            let vr = APVariadicView_MultiViewRoot(storage: views, id: UUID(), location: location, env: env, ids: ids)
            return initBranch(vr)
        }
        
        public func initBranch(_ viewRoot: APVariadicView_MultiViewRoot) -> [APAnySynView] {
            var newViews: [APAnySynView] = []
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
                    newViews.append(contentsOf: initBranch(multiRoot.storage, at: multiRoot.location!, env: multiRoot.env))
                }
            }
            return newViews
        }
    }
}

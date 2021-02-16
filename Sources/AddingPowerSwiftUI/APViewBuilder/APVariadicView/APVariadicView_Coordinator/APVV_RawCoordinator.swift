//
//  RawCoordinator.swift
//  
//
//  Created by Xuan Li on 2/15/21.
//

import SwiftUI
import Combine

extension APVariadicView {
    public class RawCoordinator: CoordinatorBase, APVariadicView_CoordinatorProtocol {
        public override init() {}
        
        public let root = APVariadicView_MultiViewRoot()
        public let rootChange = PassthroughSubject<[APVariadicView], Never>()
        public let viewRootChange = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView]), Never>()
        public let viewRootReplace = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], APPathEnvironment), Never>()
        public let viewRootModification = PassthroughSubject<(APVariadicView_MultiViewRoot, [APVariadicView], [AnyHashable]), Never>()
        
        public func toConfiguration() -> APVariadicViewRawConfiguration {
            return APVariadicViewRawConfiguration(root: self.root,
                                                  rootChange: self.rootChange.eraseToAnyPublisher(),
                                                  viewRootChange: self.viewRootChange.eraseToAnyPublisher(),
                                                  viewRootReplace: self.viewRootReplace.eraseToAnyPublisher(),
                                                  viewRootModification: self.viewRootModification.eraseToAnyPublisher())
        }
        
        public override func rootChange(_ newStorage: [APVariadicView]) {
            rootChange.send(newStorage)
        }
        
        public override func viewRootChange(_ viewRoot: APVariadicView_MultiViewRoot, _ changedStorage: [APVariadicView]) {
            viewRootChange.send((viewRoot, changedStorage))
        }
        
        public override func viewRootReplace(_ viewRoot: APVariadicView_MultiViewRoot, _ newStorage: [APVariadicView], _ env: APPathEnvironment) {
            viewRootReplace.send((viewRoot, newStorage, env))
        }
        
        public override func viewRootModification(_ viewRoot: APVariadicView_MultiViewRoot, _ modifiedStorage: [APVariadicView], _ ids: [AnyHashable]) {
            viewRootModification.send((viewRoot, modifiedStorage, ids))
        }
    }
}

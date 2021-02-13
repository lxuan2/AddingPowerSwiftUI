//
//  APVariadicView.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public enum APVariadicView: Equatable {
    public typealias UnaryViewRoot = APAnySynView
    public typealias MultiViewRoot = APVariadicView_MultiViewHost
    case unary(UnaryViewRoot)
    case multi(MultiViewRoot)
}

public protocol CoordinatorProtocol: ObservableObject {
    func updates(viewRoot: [APVariadicView], in subRoot: APVariadicView_MultiViewHost, atrribute: APPath.Attribute)
}

extension APVariadicView {
    public class CoordinatorBase: ObservableObject {
        public func updates(viewRoot: [APVariadicView], in subRoot: APVariadicView_MultiViewHost, atrribute: APPath.Attribute) {
            fatalError("CoordinatorBase: updates() not implemented in base class")
        }
    }
    
    public class Coordinator: CoordinatorBase {
        public var delegate: APVariadicView_Delegate
        public var root: APVariadicView_MultiViewHost
        public var viewList: [APAnySynView]
        public var cache: [UUID]? = []
        
        public override func updates(viewRoot: [APVariadicView], in subRoot: APVariadicView_MultiViewHost, atrribute: APPath.Attribute) {
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
        
        public func initRoot(with viewRoot: [APVariadicView]) {
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
            self.root = APVariadicView_MultiViewHost()
            self.viewList = []
        }
    }
}

extension Array {
    mutating func removeFirst(where: (Element) -> Bool) {
        if let index = firstIndex(where: `where`) {
            remove(at: index)
        }
    }
}
extension Array where Element: Equatable {
    func contains(_ subarray: [Element]) -> Bool {
        var found = 0
        for element in self where found < subarray.count {
            if element == subarray[found] {
                found += 1
            } else {
                found = element == subarray[0] ? 1 : 0
            }
        }

        return found == subarray.count
    }
}

extension APVariadicView {
    public class PrimitiveCoordinator: CoordinatorBase {
        public var delegate: APVariadicView_PrimitiveDelegate
        public var root: APVariadicView_MultiViewHost
        public var cache: [UUID]? = []
        
        public override func updates(viewRoot: [APVariadicView], in subRoot: APVariadicView_MultiViewHost, atrribute: APPath.Attribute) {
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
        
        public func initRoot(with viewRoot: [APVariadicView]) {
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
            self.root = APVariadicView_MultiViewHost()
        }
    }
}

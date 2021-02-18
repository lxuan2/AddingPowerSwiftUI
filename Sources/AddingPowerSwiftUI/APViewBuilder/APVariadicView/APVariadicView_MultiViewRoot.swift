//
//  APVariadicView_MultiViewRoot.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public class APVariadicView_MultiViewRoot: ObservableObject, Identifiable, Equatable {
    public var storage: [APVariadicView]
    public var id: UUID
    public var location: [APPath]?
    public var env: APPathEnvironment
    public var ids: [AnyHashable]
    public var viewlistCount: Int = 0
    public weak var parentViewRoot: APVariadicView_MultiViewRoot? = nil
    
    internal init(storage: [APVariadicView] = [], id: UUID = UUID(), location: [APPath]? = nil, env: APPathEnvironment = .none, ids: [AnyHashable] = [], viewlistCount: Int = 0, parentViewRoot: APVariadicView_MultiViewRoot? = nil) {
        self.storage = storage
        self.id = id
        self.location = location
        self.env = env
        self.ids = ids
        self.viewlistCount = viewlistCount
        self.parentViewRoot = parentViewRoot
    }

    
    public static func == (lhs: APVariadicView_MultiViewRoot, rhs: APVariadicView_MultiViewRoot) -> Bool {
        lhs.id == rhs.id
    }
    
    public func getPathForChild(at index: Int) -> [APPath] {
        switch env {
        case .none:
            return location! + [.any(index)]
        case .conditional(let condition):
            return location! + [condition ? .truePath(index) : .falsePath(index)]
        case .group:
            return location! + [.groupPath(index)]
        case .identifiable:
            return location! + [.idPath(ids[index])]
        }
    }
    
    public func getIndex(in location: [APPath]) -> Int {
        if let path = location.first {
            var amount = 0
            var index = 0
            
            switch path {
            case .any(let idx), .truePath(let idx), .falsePath(let idx), .groupPath(let idx):
                index = idx
            case .idPath(let _id):
                if let idx = ids.firstIndex(of: _id) {
                    index = idx
                } else {
                    fatalError("APVariadicView_MultiViewRoot: does not have \(_id) in ids")
                }
            }
            
            for i in 0..<index {
                switch self.storage[i] {
                case .unary(_):
                    amount += 1
                case .multi(let newPoint):
                    amount += newPoint.viewlistCount
                }
            }
            
            switch self.storage[index] {
            case .unary(_):
                if location.count > 1 {
                    fatalError("APVariadicView_Root.getIndex(): Invalid path")
                }
            case .multi(let newPoint):
                var newLoc = location
                newLoc.remove(at: 0)
                amount += newPoint.getIndex(in: newLoc)
            }
            return amount
        }
        return 0
    }
    
    public func getAmount() -> Int {
        var amount = 0
        for i in self.storage {
            switch i {
            case .unary(_):
                amount += 1
            case .multi(let newPoint):
                amount += newPoint.getAmount()
            }
        }
        return amount
    }
    
    private func _getLocationAndView(at index: Int, idx: inout Int, current path: [APPath]) -> ([APPath], APAnySynView)? {
        for (i, item) in storage.enumerated() {
            switch item {
            case .unary(let view):
                idx += 1
                if idx == index {
                    return (path.resolve(in: env, with: i, with: self), view)
                }
            case .multi(let point):
                if let r = point._getLocationAndView(at: index, idx: &idx, current: path.resolve(in: env, with: i, with: self)) {
                    return r
                }
            }
        }
        return nil
    }
    
    public func getLocationAndView(at index: Int) -> ([APPath], APAnySynView)? {
        if index < 0 {
            return nil
        }
        var initalIndex = -1
        return _getLocationAndView(at: index, idx: &initalIndex, current: [])
    }
}
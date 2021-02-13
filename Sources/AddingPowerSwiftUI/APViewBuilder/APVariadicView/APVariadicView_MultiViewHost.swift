//
//  APVariadicView_MultiViewHost.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public class APVariadicView_MultiViewHost: ObservableObject, Identifiable, Equatable {
    public var viewRoot: [APVariadicView] = []
    public var id: UUID = UUID()
    public var location: [APPath]?
    public var pathAttribute: APPath.Attribute = .any
    
    public init() {}
    
    public static func == (lhs: APVariadicView_MultiViewHost, rhs: APVariadicView_MultiViewHost) -> Bool {
        lhs.id == rhs.id
    }
    
    public func getIndex(in location: [APPath]) -> Int {
        if let path = location.first {
            var amount = 0
            for i in 0..<path.direction {
                switch self.viewRoot[i] {
                case .unary(_):
                    amount += 1
                case .multi(let newPoint):
                    amount += newPoint.getAmount()
                }
            }
            switch self.viewRoot[path.direction] {
            case .unary(_):
                fatalError("APVariadicView_MultiViewHost.getIndex(): Invalid path")
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
        for i in self.viewRoot {
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
        for (i, item) in viewRoot.enumerated() {
            switch item {
            case .unary(let view):
                idx += 1
                if idx == index {
                    return (path + [APPath(direction: i, attribute: .any)], view)
                }
            case .multi(let point):
                if let r = point._getLocationAndView(at: index, idx: &idx, current: path + [APPath(direction: i, attribute: .any)]) {
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

public struct APPath: Equatable {
    public enum Attribute {
        case any
        case truePath
        case falsePath
    }
    
    var direction: Int
    var attribute: Attribute
}
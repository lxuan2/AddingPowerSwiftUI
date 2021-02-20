//
//  APPath.swift
//  
//
//

import SwiftUI

public enum APPath: Equatable {
    case any(Int)
    case truePath(Int)
    case falsePath(Int)
    case idPath(AnyHashable)
    case groupPath(Int)
}

extension Array where Element == APPath {
    func resolve(in environment: APPathEnvironment, with index: Int) -> [APPath] {
        switch environment {
        case .none:
            return self + [.any(index)]
        case .conditional(let condition):
            return self + [condition ? .truePath(index) : .falsePath(index)]
        case .group:
            return self + [.groupPath(index)]
        default:
            fatalError("[APPath] cannot be resolved in \(environment) with index: \(index)")
        }
    }
    
    func resolve(in environment: APPathEnvironment, with id: AnyHashable) -> [APPath] {
        switch environment {
        case .identifiable:
            return self + [.idPath(id)]
        default:
            fatalError("[APPath] cannot be resolved in \(environment) with id: \(id)")
        }
    }
    
    func resolve(in environment: APPathEnvironment, with index: Int, with root: APVariadicView_MultiViewRoot) -> [APPath] {
        switch environment {
        case .none:
            return self + [.any(index)]
        case .conditional(let condition):
            return self + [condition ? .truePath(index) : .falsePath(index)]
        case .group:
            return self + [.groupPath(index)]
        case .identifiable:
            return self + [.idPath(root.ids[index])]
        }
    }
}


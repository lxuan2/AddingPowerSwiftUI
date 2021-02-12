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

extension APVariadicView {
    public class Coordinator: ObservableObject {
        public var delegate: APVariadicView_Delegate?
        public var root: [APVariadicView] = []
        public func updateViews(_ views: [APVariadicView], with root: APVariadicView_MultiViewHost, operation: Operation) {
            if let loc = root.location {
                let index = getIndex(at: loc, start: self.root)
                if root.isInited {
                    switch operation {
                    case .conditional:
                        sendToDelegate(at: index, remove: getAmount(in: root.body), add: initTree(views, at: loc))
                    }
                } else {
                    sendToDelegate(at: index, remove: 0, add: initTree(views, at: loc))
                }
            }
            root.body = views
        }
        
        public func getIndex(at path: [Int], start point: [APVariadicView]) -> Int {
            if let index = path.first {
                var amount = 0
                for i in 0..<index {
                    switch point[i] {
                    case .unary(_):
                        amount += 1
                    case .multi(let newPoint):
                        amount += getIndex(at: Array(path[1...]), start: newPoint.body)
                    }
                }
                return amount
            }
            return getAmount(in: point)
        }
        
        public func getAmount(in point: [APVariadicView]) -> Int {
            var amount = 0
            for i in point {
                switch i {
                case .unary(_):
                    amount += 1
                case .multi(let newPoint):
                    amount += getAmount(in: newPoint.body)
                }
            }
            return amount
        }
        
        public func initialize(_ views: [APVariadicView]) {
            // assign locations
            root = views
            sendToDelegate(at: 0, remove: 0, add: initTree(views, at: []))
            
        }
        
        public func initTree(_ views: [APVariadicView], at location: [Int]) -> [APAnySynView] {
            var newViews: [APAnySynView] = []
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(let nv):
                    newViews.append(nv)
                case .multi(let multiroot):
                    let loc = location + [i]
                    multiroot.location = loc
                    multiroot.isInited = true
                    newViews.append(contentsOf: initTree(multiroot.body, at: loc))
                }
            }
            return newViews
        }
        
        public func sendToDelegate(at index: Int, remove amount: Int, add newViews: [APAnySynView]) {
//            print("sendToDelegate(at index: \(index), remove amount: \(amount), add newViews: \(newViews)")
            delegate?.operate(at: index, remove: amount, add: newViews)
        }
        
        public init() {
            self.delegate = nil
        }
        
        public enum Operation {
            case conditional
        }
    }
}

extension APVariadicView {
//    public struct Tree<Root: APVariadicView_Root, Content: View>: View {
//        public var root: Root
//        public var content: Content
//        @StateObject private var coordinator = APVariadicView.Coordinator()
//
//        public var body: some View {
//            coordinator.delegate = root.operate
//            return root
//                .background(
//                    content
//                        .onPreferenceChange(APVariadicView_PreferenceKey.self) { views in
//                            coordinator.initialize(views)
//                        }
//                        .environmentObject(coordinator)
//                )
//        }
//
//        @inlinable public init(root: Root, content: Content) {
//            self.root = root
//            self.content = content
//        }
//        @inlinable public init(_ root: Root, @ViewBuilder content: () -> Content) {
//            self.root = root
//            self.content = content()
//        }
//    }
    
    public struct TreeModifier<APViewBuilderResult: View>: ViewModifier {
        @StateObject private var coordinator = APVariadicView.Coordinator()
        let result: APViewBuilderResult
        let delegate: APVariadicView_Delegate
        
        public func body(content: Content) -> some View {
            coordinator.delegate = delegate
            return content
                .background(
                    result
                        .onPreferenceChange(APVariadicView_PreferenceKey.self) { views in
                            coordinator.initialize(views)
                        }
                        .environmentObject(coordinator)
                )
        }
    }
}

extension View {
    public func treeView<APVariadicView_Type: View>(_ view: APVariadicView_Type, delegate: APVariadicView_Delegate) -> some View {
        modifier(APVariadicView.TreeModifier(result: view, delegate: delegate))
    }
}

public protocol APVariadicView_Delegate {
    func operate(at index: Int, remove amount: Int, add newViews: [APAnySynView])
}

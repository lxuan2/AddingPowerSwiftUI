//
//  APVariadicView.swift
//  
//
//  Created by Xuan Li on 2/11/21.
//

import SwiftUI

public enum APVariadicView: Equatable {
    case unary(APVariadicView_UnaryViewRoot)
    case multi(APVariadicView_MultiViewRoot)
}

public typealias APVariadicView_UnaryViewRoot = APAnySynView

public protocol APVariadicView_Root {
    associatedtype Body: View
    func makeBody(coordinator: Coordinator) -> Body
    associatedtype Coordinator: APVariadicView_RootCoordinator
    func makeCoordinator() -> Coordinator
}

public protocol APVariadicView_RootCoordinator {
    func onRootChange(storage: [APVariadicView])
    func onChange(in viewRoot: APVariadicView_MultiViewRoot, with changedStorage: [APVariadicView])
    func onReplace(in viewRoot: APVariadicView_MultiViewRoot, with newStorage: [APVariadicView], env: APPathEnvironment)
    func onModification(in viewRoot: APVariadicView_MultiViewRoot, with changedStorage: [APVariadicView], with ids: [AnyHashable])
}

public class APVariadicView_RootCoordinatorHolder: ObservableObject {
    public init<Coordinator: APVariadicView_RootCoordinator>(_ body: Coordinator) {
        self.body = body
    }
    
    public var body: APVariadicView_RootCoordinator
}

extension APVariadicView {
    @frozen public struct Tree<Root: APVariadicView_Root, Content: View>: View {
        public var root: Root
        public var content: Content
        @StateObject private var coordinator: APVariadicView_RootCoordinatorHolder
        
        public init(root: Root, content: Content) {
            self.root = root
            self.content = content
            self._coordinator = .init(wrappedValue: .init(root.makeCoordinator()))
        }
        
        public init(_ root: Root, @APViewBuilder content: () -> Content) {
            self.init(root: root, content: content())
        }
        
        public var body: some View {
            root.makeBody(coordinator: coordinator.body as! Root.Coordinator)
                .background(
                    content
                        .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                            coordinator.body.onRootChange(storage: $0)
                        }
                        .environmentObject(coordinator)
                )
        }
    }
}

public struct APVariadicView_PrimitiveRoot<Content: View>: APVariadicView_Root {
    let content: Content
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeBody(coordinator: Coordinator) -> some View {
        return content
    }
    
    public class Coordinator: APVariadicView_RootCoordinator {
        public var cache: [UUID]? = []
        public var viewRoot = APVariadicView_MultiViewRoot()
        
        public init() {}
        
        public func onRootChange(storage: [APVariadicView]) {
            initBranch(storage, at: [], env: .none)
            viewRoot.storage = storage
        }
        
        public func onChange(in viewRoot: APVariadicView_MultiViewRoot, with changedStorage: [APVariadicView]) {
            onReplace(in: viewRoot, with: changedStorage, env: viewRoot.env)
        }
        
        public func onReplace(in viewRoot: APVariadicView_MultiViewRoot, with newStorage: [APVariadicView], env: APPathEnvironment) {
            if let loc = viewRoot.location {
                initBranch(newStorage, at: loc, env: env)
                let isInited = cache == nil
                if isInited {
//                    delegate?.viewRoot(viewRoot: viewRoot, willUpdate: newStorage, in: viewRoot)
                }
                viewRoot.storage = newStorage
                viewRoot.env = env
                if isInited {
//                    delegate?.viewRoot(viewRoot: viewRoot, didUpdate: newStorage, in: viewRoot)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
//                        delegate?.initial(viewRoot)
                        cache = nil
                    }
                }
            } else {
                viewRoot.storage = newStorage
                viewRoot.env = env
            }
        }
        
        public func onModification(in viewRoot: APVariadicView_MultiViewRoot, with changedStorage: [APVariadicView], with ids: [AnyHashable]) {
            if let loc = viewRoot.location {
                initBranch(changedStorage, at: loc, env: viewRoot.env)
                let isInited = cache == nil
                if isInited {
//                    delegate?.viewRoot(viewRoot: viewRoot, willUpdate: changedStorage, in: viewRoot)
                }
                viewRoot.storage = changedStorage
                viewRoot.ids = ids
                if isInited {
//                    delegate?.viewRoot(viewRoot: viewRoot, didUpdate: changedStorage, in: viewRoot)
                }
                if !isInited {
                    cache!.removeFirst(where: { $0 == viewRoot.id })
                    if cache!.isEmpty {
//                        delegate?.initial(viewRoot)
                        cache = nil
                    }
                }
            } else {
                viewRoot.storage = changedStorage
                viewRoot.ids = ids
            }
        }
        
        private func initBranch(_ views: [APVariadicView], at location: [APPath], env: APPathEnvironment) {
            for (i, item) in views.enumerated() {
                switch item {
                case .unary(_):
                    break
                case .multi(let multiroot):
                    if multiroot.location == nil {
                        if cache != nil {
                            cache!.append(multiroot.id)
                        }
                        multiroot.location = location.resolve(in: env, with: i)
                    }
                    initBranch(multiroot.storage, at: multiroot.location!, env: multiroot.env)
                }
            }
        }
    }
}

//protocol IT {
//    associatedtype Body: View = ZStack<EmptyView>
//    @ViewBuilder var body: Body { get }
//}
//
//extension IT {
//    var body: Text {
//        Text("d")
//    }
//}
//
//struct x: IT {
//
//    var body: Color {
//        Color.red
//    }
//
//
//}
//
//let i = x()

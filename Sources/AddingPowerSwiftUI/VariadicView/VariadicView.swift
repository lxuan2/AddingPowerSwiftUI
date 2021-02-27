//
//  VariadicView.swift
//  
//
//  Created by Xuan Li on 2/23/21.
//

import SwiftUI

// MARK: - Visitor

public protocol Visitor {
    static func visit<ViewRoot: VariadicView_UnaryViewRoot>(visitor: Self, unaryViewRoot: ViewRoot)
    static func visit<ViewRoot: VariadicView_MultiViewRoot>(visitor: Self, multiViewRoot: ViewRoot)
    static func visit(visitor: Self, image: APImage_ViewRoot)
    static func visit(visitor: Self, tree: VariadicView_TreeViewRoot)
}

extension Visitor {
    public static func visit(visitor: Self, image: APImage_ViewRoot) {
        Self.visit(visitor: visitor, unaryViewRoot: image)
    }
    
    public static func visit(visitor: Self, tree: VariadicView_TreeViewRoot) {
        Self.visit(visitor: visitor, multiViewRoot: tree)
    }
}

public class APImage_ViewRoot: VariadicView_UnaryViewRoot {
    public var id: AnyHashable = UUID()
    public var body: APImage
    public var subscriber: WeakSubscriber
    
    public init(body: APImage) {
        self.body = body
        self.subscriber = WeakSubscriber(value: nil)
    }
    
    public static func accept<V>(visitor: V, viewRoot: APImage_ViewRoot) where V : Visitor {
        V.visit(visitor: visitor, image: viewRoot)
    }
}

extension UIHostingView: VariadicView_UnaryViewRootSubscriber {
    public func getUIView() -> UIView {
        self
    }
}

// MARK: - VariadicView_Root

public protocol VariadicView_Root {
    associatedtype Body: View
    func makeBody(configuration: VariadicView_RootConfiguration) -> Body
}

public struct VariadicView_RootConfiguration {
    var tree: VariadicView_TreeViewRoot
}

// MARK: - VariadicView_ViewRoot

public protocol VariadicView_ViewRoot: AnyObject, Identifiable {
    var id: AnyHashable { get }
    static func makeView(viewRoot: Self) -> UIView
    static func accept<V: Visitor>(visitor: V, viewRoot: Self)
}

// MARK: - VariadicView_UnaryViewRoot

public protocol VariadicView_UnaryViewRoot : VariadicView_ViewRoot {
    associatedtype Body: View
    var body: Body { get }
    var subscriber: WeakSubscriber { get set }
}

extension VariadicView_UnaryViewRoot {
    public static func makeView(viewRoot: Self) -> UIView {
        if let s = viewRoot.subscriber.value {
            return s.getUIView()
        }
        let value = UIHostingView(rootView: viewRoot.body)
        viewRoot.subscriber.value = value
        return value
    }
}

public struct WeakSubscriber {
    weak var value: VariadicView_UnaryViewRootSubscriber?
}

public protocol VariadicView_UnaryViewRootSubscriber: AnyObject {
    func getUIView() -> UIView
}

// MARK: - VariadicView_MultiViewRoot

public protocol VariadicView_MultiViewRoot : VariadicView_ViewRoot {
    var children: [VariadicView] { get }
}

public class VariadicView_TreeViewRoot: VariadicView_MultiViewRoot, ObservableObject {
    public let id: AnyHashable = UUID()
    public var children: [VariadicView] = []
    @Published public var isInited: Bool = false
    
    public init() {}
    
    public static func makeView(viewRoot: VariadicView_TreeViewRoot) -> UIView {
        // FIXME: USE HStack as default
        return UIView()
    }
    
    public static func accept<V>(visitor: V, viewRoot: VariadicView_TreeViewRoot) where V : Visitor {
        V.visit(visitor: visitor, tree: viewRoot)
    }
}

public struct VariadicView_Children {
    
}

// MARK: - ViewBuilder result type

protocol _View {
    associatedtype ViewBody: View
    associatedtype _ViewBody: View
    static func makeView(view: Self) -> ViewBody
    static func make_View(view: Self) -> _ViewBody
}

// MARK: - Transmission Variable

public class AnyVariadicView_ViewRootBox: Identifiable, Equatable {
    public func visit<V: Visitor>(visitor: V) {
        fatalError("AnyVariadicView_ViewRootBox: base class is not implemented")
    }
    
    public var id: AnyHashable {
        fatalError("AnyVariadicView_ViewRootBox: base class is not implemented")
    }
    
    public static func == (lhs: AnyVariadicView_ViewRootBox, rhs: AnyVariadicView_ViewRootBox) -> Bool {
        lhs.id == rhs.id
    }
}

public class VariadicView_ViewRootBox<Base: VariadicView_ViewRoot>: AnyVariadicView_ViewRootBox {
    var base: Base
    
    public init(base: Base) {
        self.base = base
    }
    
    public override func visit<V>(visitor: V) where V : Visitor {
        Base.accept(visitor: visitor, viewRoot: base)
    }
    
    public override var id: AnyHashable {
        base.id
    }
}

public struct VariadicView: Equatable {
    var viewRoot: AnyVariadicView_ViewRootBox
    
    public init<Root: VariadicView_ViewRoot>(root: Root) {
        self.viewRoot = VariadicView_ViewRootBox(base: root)
    }
    
    public func visit<V: Visitor>(visitor: V) {
        viewRoot.visit(visitor: visitor)
    }
    
    public struct Tree<Root: VariadicView_Root, Content: View>: View {
        public var root: Root
        public var content: Content
        @StateObject private var tree = VariadicView_TreeViewRoot()
        
        public var body: some View {
            ZStack {
                APEquatableView(id: tree.id) {EmptyView()}
                if tree.isInited {
                    root.makeBody(configuration: .init(tree: tree))
                }
            }
            .background(
                content
                    .onPreferenceChange(VariadicView_PreferenceKey.self) {
                        tree.children = $0
                    }
            )
        }
    }
}

public struct VariadicView_PreferenceKey: PreferenceKey {
    public static var defaultValue: [VariadicView] = []
    
    public static func reduce(value: inout [VariadicView], nextValue: () -> [VariadicView]) {
        value.append(contentsOf: nextValue())
    }
}

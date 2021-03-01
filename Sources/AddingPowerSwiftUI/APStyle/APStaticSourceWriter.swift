//
//  APStaticSourceWriter.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStaticSourceWriter

struct APStaticSourceWriter<Canvas: APCanvas, Source: View>: ViewModifier {
    @StateObject private var coordinator: Coordinator
    var source: Source
    
    public func body(content: Content) -> some View {
        coordinator.updateView(source)
        return content.environment(\.[HashableType(Canvas.self)], coordinator)
    }
    
    public init(source: Source) {
        self.source = source
        self._coordinator = .init(wrappedValue: .init(source: source))
    }
}

extension APStaticSourceWriter {
    class Coordinator: APCanvasCoordinator {
        private var source: Source
        private var subscribers: [Subscriber]
        
        init(source: Source) {
            self.source = source
            self.subscribers = []
        }
        
        override func makeViewController() -> UIViewController {
            let vc = UIHostingController(rootView: source)
            subscribers.append(Subscriber(some: vc))
            return vc
        }
        
        func updateView(_ newSource: Source) {
            source = newSource
            subscribers.removeAll {
                $0.some == nil
            }
            subscribers.forEach {
                $0.some!.rootView = newSource
            }
        }
        
        private struct Subscriber {
            weak var some: UIHostingController<Source>?
        }
    }
}

// MARK: - fill(_:,with:)

extension View {
    func fill<Canvas: APCanvas, Source: View>(_ key: Canvas.Type, with source: Source) -> some View {
        modifier(APStaticSourceWriter<Canvas, Source>(source: source))
    }
}

// MARK: - HashableType

public struct HashableType<T> : Hashable {
    
    public static func == (lhs: HashableType, rhs: HashableType) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: T.Type
    
    public init(_ base: T.Type) {
        self.base = base
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }
}

// MARK: - Type of EnvironmentKey as Key

extension EnvironmentValues {
    public subscript<K>(key: HashableType<K>) -> K.Value where K: EnvironmentKey {
        get { self[K] }
        set { self[K] = newValue }
    }
}


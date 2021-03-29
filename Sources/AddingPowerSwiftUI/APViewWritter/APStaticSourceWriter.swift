//
//  APStaticSourceWriter.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStaticSourceWriter

public struct StaticSourceWriter<Key: APStaticSourceKey, Source: View>: ViewModifier {
    var source: Source
    
    public func body(content: Content) -> some View {
        _VariadicView.Tree(HostView(content: content)) {
            source
        }
    }
    
    public init(key: Key.Type = Key.self, source: Source) {
        self.source = source
    }
    
    struct HostView: _VariadicView_UnaryViewRoot {
        var content: Content
        
        func body(children: _VariadicView.Children) -> some View {
            content.environment(Key.self, children)
        }
    }
}

// MARK: - fill(_:,with:)

extension View {
    public func fill<Key: APStaticSourceKey, Source: View>(_ key: Key.Type = Key.self, source: Source) -> some View {
        modifier(StaticSourceWriter(key: key, source: source))
    }
}

// MARK: - APStaticSourceKey

public protocol APStaticSourceKey: EnvironmentKey where Value == _VariadicView.Children? {}

extension APStaticSourceKey {
    public static var defaultValue: Value {
        nil
    }
}

// MARK: - Type of EnvironmentKey as Key

extension EnvironmentValues {
    public subscript<K>(key: HashableType<K>) -> K.Value where K: EnvironmentKey {
        get { self[K] }
        set { self[K] = newValue }
    }
}

extension Environment {
    @inlinable public init<Key: EnvironmentKey>(_ key: Key.Type = Key.self) where Key.Value == Value {
        self.init(\.[HashableType(Key.self)])
    }
}

extension View {
    @inlinable func environment<Key: EnvironmentKey>(_ key: Key.Type = Key.self, _ value: Key.Value) -> some View {
        environment(\.[HashableType(Key.self)], value)
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

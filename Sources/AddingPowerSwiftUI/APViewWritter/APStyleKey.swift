//
//  APStyleKey.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStyleKey

public protocol APStyleKey: EnvironmentKey where Value == APStylePayload<Configuration>? {
    associatedtype Configuration
    associatedtype Body: View
    static func makeDefault(configuration: Configuration) -> Body
}

extension APStyleKey {
    public static var defaultValue: Value { nil }
}

// MARK: - APStyleView

public struct APStyleView<Key: APStyleKey>: View {
    @Environment(Key.self) var style
    var configuration: Key.Configuration
    
    public init(key: Key.Type = Key.self, configuration: Key.Configuration) {
        self.configuration = configuration
    }
    
    public var body: some View {
        if let s = style {
            s.makeContent(configuration)
        } else {
            Key.makeDefault(configuration: configuration)
        }
    }
}

// MARK: - APStyleModifier

extension View {
    func style<Key: APStyleKey, Content: View>(_ key: Key.Type = Key.self, body: @escaping (Key.Configuration) -> Content) -> some View {
        environment(Key.self, APStylePayload(makeContent: body))
    }
}

// MARK: - APStylePayload

public struct APStylePayload<Configuration> {
    var makeContent: (Configuration) -> ModifiedContent<APAnyRepresentable, _SafeAreaIgnoringLayout>
    
    init<Content: View>(makeContent: @escaping (Configuration) -> Content) {
        self.makeContent = {
            ModifiedContent(content: APAnyRepresentable(makeContent($0)), modifier: _SafeAreaIgnoringLayout(edges: .all))
        }
    }
}

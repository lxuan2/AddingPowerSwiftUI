//
//  APStyleWritter.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStyleWritter

public struct APStyleWritter<Key: APStyleKey, StyleContent: View>: ViewModifier {
    @StateObject private var coordinator: Coordinator
    let styleContent: (Key.Configuration) -> StyleContent
    
    public func body(content: Content) -> some View {
        coordinator.updateStyle(content: styleContent)
        return content.environment(\.[HashableType(Key.self)], coordinator)
    }
    
    public init(_ key: Key.Type, _ content: @escaping (Key.Configuration) -> StyleContent) {
        self._coordinator = .init(wrappedValue: .init(content: content))
        self.styleContent = content
    }
}

extension APStyleWritter {
    class Coordinator: APStyleCoordinator<Key.Configuration>, ObservableObject {
        private var content: (Key.Configuration) -> StyleContent
        private var subscribers: [Subscriber]
        
        init(content: @escaping (Key.Configuration) -> StyleContent) {
            self.content = content
            self.subscribers = []
        }
        
        override func makeViewController(configuration: Key.Configuration) -> UIViewController {
            let vc = UIHostingController(rootView: content(configuration))
            subscribers.append(.init(some: vc, configuration: configuration))
            return vc
        }
        
        override func updateConfiguration(configuration: Key.Configuration, uiviewController: UIViewController) {
            subscribers.removeAll { $0.some == nil }
            if let index = subscribers.firstIndex(where: { $0.some == uiviewController }) {
                subscribers[index].configuration = configuration
                subscribers[index].some?.rootView = content(configuration)
            }
        }
        
        func updateStyle(content: @escaping (Key.Configuration) -> StyleContent) {
            self.content = content
            subscribers.removeAll { $0.some == nil }
            subscribers.forEach { $0.some!.rootView = content($0.configuration) }
        }
        
        private struct Subscriber {
            weak var some: UIHostingController<StyleContent>?
            var configuration: Key.Configuration!
        }
    }
}

// MARK: - style(_:,_:)

extension View {
    public func style<Key: APStyleKey, Content: View>(_ key: Key.Type = Key.self, _ content: @escaping (Key.Configuration) -> Content) -> some View {
        modifier(APStyleWritter(key, content))
    }
}

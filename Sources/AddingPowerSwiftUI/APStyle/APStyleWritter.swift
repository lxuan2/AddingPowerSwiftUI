//
//  APStyleWritter.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

public struct APStyleWritter<Key: APStyleKey, Style: View>: ViewModifier {
    @StateObject private var coordinator: Coordinator
    let style: (Key.Configuration) -> Style
    
    public func body(content: Content) -> some View {
        coordinator.updateStyle(style: style)
        return content.environment(\.[HashableType(Key.self)], coordinator)
    }
    
    public init(_ key: Key.Type, _ style: @escaping (Key.Configuration) -> Style) {
        self._coordinator = .init(wrappedValue: .init(style: style))
        self.style = style
    }
}

extension APStyleWritter {
    class Coordinator: APStyleCoordinatorBase<Key.Configuration>, ObservableObject {
        private var style: (Key.Configuration) -> Style
        private var subscribers: [Subscriber]
        
        init(style: @escaping (Key.Configuration) -> Style) {
            self.style = style
            self.subscribers = []
        }
        
        override func makeViewController(configuration: Key.Configuration) -> UIViewController {
            let vc = UIHostingController(rootView: style(configuration))
            subscribers.append(.init(some: vc, configuration: configuration))
            return vc
        }
        
        override func updateConfiguration(configuration: Key.Configuration, uiviewController: UIViewController) {
            subscribers.removeAll {
                $0.some == nil
            }
            if let index = subscribers.firstIndex(where: { $0.some == uiviewController }) {
                subscribers[index].configuration = configuration
                subscribers[index].some?.rootView = style(configuration)
            }
        }
        
        func updateStyle(style: @escaping (Key.Configuration) -> Style) {
            self.style = style
            subscribers.removeAll {
                $0.some == nil
            }
            subscribers.forEach {
                $0.some!.rootView = style($0.configuration)
            }
        }
        
        private struct Subscriber {
            weak var some: UIHostingController<Style>?
            var configuration: Key.Configuration!
        }
    }
}

public class APStyleCoordinatorBase<Configuration> {
    func makeViewController(configuration: Configuration) -> UIViewController {
        fatalError()
    }
    
    func updateConfiguration(configuration: Configuration, uiviewController: UIViewController) {
        fatalError()
    }
}

extension View {
    public func style<Key: APStyleKey, Style: View>(_ key: Key.Type, _ style: @escaping (Key.Configuration) -> Style) -> some View {
        modifier(APStyleWritter(key, style))
    }
}

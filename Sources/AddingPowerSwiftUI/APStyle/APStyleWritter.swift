//
//  APStyleWritter.swift
//  
//
//  Created by Xuan Li on 2/26/21.
//

import SwiftUI

// MARK: - APStyleWritter

public struct APStyleWritter<Canvas: APStyleCanvas, StyleContent: View>: ViewModifier {
    @StateObject private var coordinator: Coordinator
    let styleContent: (Canvas.Configuration) -> StyleContent
    
    public func body(content: Content) -> some View {
        coordinator.updateStyle(content: styleContent)
        return content.environment(\.[HashableType(Canvas.self)], coordinator)
    }
    
    public init(_ canvas: Canvas.Type, _ content: @escaping (Canvas.Configuration) -> StyleContent) {
        self._coordinator = .init(wrappedValue: .init(content: content))
        self.styleContent = content
    }
}

extension APStyleWritter {
    class Coordinator: APStyleCanvasCoordinator<Canvas.Configuration>, ObservableObject {
        private var content: (Canvas.Configuration) -> StyleContent
        private var subscribers: [Subscriber]
        
        init(content: @escaping (Canvas.Configuration) -> StyleContent) {
            self.content = content
            self.subscribers = []
        }
        
        override func makeViewController(configuration: Canvas.Configuration) -> UIViewController {
            let vc = UIHostingController(rootView: content(configuration))
            subscribers.append(.init(some: vc, configuration: configuration))
            return vc
        }
        
        override func updateConfiguration(configuration: Canvas.Configuration, uiviewController: UIViewController) {
            subscribers.removeAll { $0.some == nil }
            if let index = subscribers.firstIndex(where: { $0.some == uiviewController }) {
                subscribers[index].configuration = configuration
                subscribers[index].some?.rootView = content(configuration)
            }
        }
        
        func updateStyle(content: @escaping (Canvas.Configuration) -> StyleContent) {
            self.content = content
            subscribers.removeAll { $0.some == nil }
            subscribers.forEach { $0.some!.rootView = content($0.configuration) }
        }
        
        private struct Subscriber {
            weak var some: UIHostingController<StyleContent>?
            var configuration: Canvas.Configuration!
        }
    }
}

// MARK: - style(_:,_:)

extension View {
    public func style<Canvas: APStyleCanvas, Content: View>(_ canvas: Canvas.Type, _ content: @escaping (Canvas.Configuration) -> Content) -> some View {
        modifier(APStyleWritter(canvas, content))
    }
}

//
//  APAnyUniqueView.swift
//  
//
//

import SwiftUI

public struct APAnyUniqueView: Equatable, Identifiable {
    
    public var storage: APAnyUniqueViewStorageBase
    
    @inlinable public init(storage: APAnyUniqueViewStorageBase) {
        self.storage = storage
    }
    
    @inlinable public func getView() -> ClassView {
        storage.getView()
    }
    
    @inlinable public var isInUse: Bool {
        storage.isInUse
    }
    
    @inlinable public var id: UUID {
        storage.id
    }
}

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
extension APAnyUniqueView: UIViewRepresentable {
    public func makeUIView(context: Context) -> UIView {
        storage.getView()
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

#elseif os(macOS)
extension APAnyUniqueView: NSViewRepresentable {
    public func makeNSView(context: Context) -> NSView {
        storage.getView()
    }
    
    public func updateNSView(_ nsView: NSView, context: Context) {}
}
#endif

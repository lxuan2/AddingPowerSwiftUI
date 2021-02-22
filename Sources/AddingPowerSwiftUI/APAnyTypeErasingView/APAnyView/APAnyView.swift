//
//  APAnyView.swift
//
//
//

import SwiftUI

/// An `APAnyView` is a type erasing view used for transfering one view to
/// antoher place for rendering. Note: each storage maintains one uiviewcontroller at
/// a time. In other words, `makeUIViewController(context:)` can only be
/// called once.
///
/// The type information is hidden in underlining storage. The view update is handled
/// by the location which creates the storage. The view make is handled by the exact
/// location which rendered it. This is a very effiecent method to make and update
/// the view when transfering one view to another place through envrionment or
/// preference path.
public struct APAnyView: Equatable, Identifiable {
    public var id: UUID {
        storage.id
    }
    
    public var storage: APAnyViewStorageBase
    
    public init(storage: APAnyViewStorageBase) {
        self.storage = storage
    }
    
    @inlinable public func makeView() -> ClassView {
        storage.makeView()
    }
}

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
extension APAnyView: UIViewRepresentable {
    public func makeUIView(context: Context) -> UIView {
        storage.makeView()
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

#elseif os(macOS)
extension APAnyView: NSViewRepresentable {
    public func makeNSView(context: Context) -> NSView {
        storage.makeView()
    }
    
    public func updateNSView(_ nsView: NSView, context: Context) {}
}
#endif

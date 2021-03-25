//
//  HostingView.swift
//  
//
//  Created by Xuan Li on 2/22/21.
//

import SwiftUI

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

public typealias HostView = UIHostingView
public typealias ClassView = UIView

/// A `UIView` subclass capable of hosting a SwiftUI view.
@available(iOS 13.0, tvOS 13.0, *)
@available(OSX, unavailable)
@available(watchOS, unavailable)
open class UIHostingView<ContentBody: View>: UIView {
    private let hostingController: UIHostingController<ContentBody>
    
    public var rootView: ContentBody {
        get {
            hostingController.rootView
        } set {
            hostingController.rootView = newValue
        }
    }
    
    public required init(rootView: ContentBody) {
        hostingController = UIHostingController(rootView: rootView)
        
        super.init(frame: .zero)
        
        hostingController.view.backgroundColor = .clear
        
        addSubview(hostingController.view)
        
        hostingController.view.constrainEdges(to: self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        hostingController.sizeThatFits(in: size)
    }
    
    override open func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        hostingController.sizeThatFits(in: targetSize)
    }
    
    override open func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority
    ) -> CGSize {
        hostingController.sizeThatFits(in: targetSize)
    }
    
    override open func sizeToFit() {
        if let superview = superview {
            frame.size = hostingController.sizeThatFits(in: superview.frame.size)
        } else {
            super.sizeToFit()
        }
    }
}

extension UIView {
    func constrainEdges(to other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }
}

#elseif os(macOS)

public typealias HostView = NSHostingView
public typealias ClassView = NSView

/// A `NSView` subclass capable of hosting a SwiftUI view.
@available(OSX 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
open class NSHostingView<Content: View>: NSView {
    private let hostingController: NSHostingController<Content>
    
    public var rootView: Content {
        get {
            hostingController.rootView
        } set {
            hostingController.rootView = newValue
        }
    }
    
    public required init(rootView: Content) {
        hostingController = NSHostingController(rootView: rootView)
        
        super.init(frame: .zero)
        
        addSubview(hostingController.view)
        
        hostingController.view.constrainEdges(to: self)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NSView {
    func constrainEdges(to other: NSView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }
}

#endif

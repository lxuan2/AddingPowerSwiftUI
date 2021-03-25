//
//  APNavigationController.swift
//  
//
//

#if canImport(UIKit)
#elseif canImport(AppKit)
#endif

import SwiftUI

public class APNavigationController: UINavigationController, ObservableObject {
    public var rootID: UUID?
    public var rootLocation: [APPath]?
    public var root: APAnyUniqueView? {
        get {
            _root.wrappedRootView.content
        }
        set {
            if _root.wrappedRootView.content != newValue {
                _root.wrappedRootView = ModifiedContent(content: newValue, modifier: _SafeAreaIgnoringLayout(edges: [.horizontal, .bottom]))
            }
        }
    }
    public unowned var _root: APNavigationPageController<ModifiedContent<APAnyUniqueView?, _SafeAreaIgnoringLayout>>
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBar.prefersLargeTitles = true
    }
    
    public init() {
        let x: APAnyUniqueView? = nil
        let r = APNavigationPageController(rootView: ModifiedContent(content: x, modifier: _SafeAreaIgnoringLayout(edges: [.horizontal, .bottom])))
        self._root = r
        super.init(rootViewController: r)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

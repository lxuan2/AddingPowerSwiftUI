//
//  APUIBarButtonItem.swift
//  
//
//  Created by Xuan Li on 3/7/21.
//

import SwiftUI

public class APUIBarButtonItem: UIBarButtonItem {
    var host: UIHostingController<_VariadicView.Children.Element>?
    var _actionHandler: (() -> Void)?
    var id: AnyHashable!
    
    @objc func actionHandler() {
        _actionHandler?()
    }
}

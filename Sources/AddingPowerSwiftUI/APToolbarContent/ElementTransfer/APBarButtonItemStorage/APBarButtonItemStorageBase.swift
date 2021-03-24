//
//  APBarButtonItemStorageBase.swift
//  
//
//  Created by Xuan Li on 3/23/21.
//

import SwiftUI

class APBarButtonItemStorageBase: ObservableObject, Equatable {
    func getBarButtonItem(key: AnyHashable) -> UIBarButtonItem {
        fatalError("APBarButtonItemStorageBase: base class is not implemented!")
    }
    
    func getView(key: AnyHashable) -> UIView {
        fatalError("APBarButtonItemStorageBase: base class is not implemented!")
    }
    
    func getItemGroup(_ elements: [_VariadicView.Children.Element]) -> [APBarButtonItem] {
        fatalError("APBarButtonItemStorageBase: base class is not implemented!")
    }
    
    static func == (lhs: APBarButtonItemStorageBase, rhs: APBarButtonItemStorageBase) -> Bool {
        lhs === rhs
    }
}

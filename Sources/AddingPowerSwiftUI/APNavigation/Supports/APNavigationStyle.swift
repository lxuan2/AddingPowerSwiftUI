//
//  SwiftUIView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import SwiftUI

protocol APNavigationStyle {
    associatedtype _Body : SwiftUI.View
    func _body(configuration: SwiftUI._NavigationViewStyleConfiguration) -> Self._Body
}

//public struct _NavigationViewStyleConfiguration {
//  public struct Content : SwiftUI.View {
//    public typealias Body = Swift.Never
//  }
//  public let content: SwiftUI._NavigationViewStyleConfiguration.Content
//}

public struct NewStyle: NavigationViewStyle {
    public func _body(configuration: _NavigationViewStyleConfiguration) -> some View {
        NavigationView {
            configuration.content
        }
    }
    
    public init() {
        
    }
}

public struct ickerStyle : SwiftUI.PickerStyle {
    public static func _makeView<SelectionValue>(value: _GraphValue<_PickerValue<ickerStyle, SelectionValue>>, inputs: _ViewInputs) -> _ViewOutputs where SelectionValue : Hashable {
        SegmentedPickerStyle._makeView(value: value as! _GraphValue<_PickerValue<SegmentedPickerStyle, SelectionValue>>, inputs: inputs)
    }
    
    public static func _makeViewList<SelectionValue>(value: _GraphValue<_PickerValue<ickerStyle, SelectionValue>>, inputs: _ViewListInputs) -> _ViewListOutputs where SelectionValue : Hashable {
        dump(value)
//        dump(inputs)
        
        return SegmentedPickerStyle._makeViewList(value: value as! _GraphValue<_PickerValue<SegmentedPickerStyle, SelectionValue>>, inputs: inputs)
    }
    
    public init() {
        
    }
    @inlinable func intd<T>(_ tuple: TupleView<T>) {
        
    }
    
    
}

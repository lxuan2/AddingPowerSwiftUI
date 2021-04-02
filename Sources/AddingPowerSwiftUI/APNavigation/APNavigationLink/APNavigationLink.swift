//
//  APNavigationLink.swift
//  
//
//

import SwiftUI

public struct APNavigationLink<Label: View, Destination: View>: View {
    var destination: Destination
    var label: Label
    var isDetail: Bool
    var bindingIsActive: Binding<Bool>?
    @State private var isActive: Bool = false
    @Environment(\.apNVC) private var nvcBox
    
    public var body: some View {
        Button {
            if let b = bindingIsActive {
                b.wrappedValue = true
            } else {
                isActive = true
            }
        } label: {
            label
        }
        .transformEnvironment(\.isEnabled) { isEnabled in
            if isEnabled, nvcBox.controller == nil {
                isEnabled = false
            }
        }
        .apNavigationDestination(destination, isPresent: bindingIsActive ?? $isActive, isDetail: isDetail)
    }
    
    public init(destination: Destination, isActive: Binding<Bool>, label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.isDetail = true
        self.bindingIsActive = isActive
    }
    
    public init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.isDetail = true
        self.bindingIsActive = nil
    }
    
    public init<V>(destination: Destination, tag: V, selection: Binding<V?>, label: () -> Label) where V : Hashable {
        self.destination = destination
        self.label = label()
        self.isDetail = true
        self.bindingIsActive = Binding {
            selection.wrappedValue == tag
        } set: { newValue in
            selection.wrappedValue =  newValue ? tag : nil
        }
    }
}

extension APNavigationLink where Label == Text {
    public init(_ titleKey: LocalizedStringKey, destination: Destination) {
        self.destination = destination
        self.label = Text(titleKey)
        self.isDetail = true
        self.bindingIsActive = nil
    }
    
    public init<S>(_ title: S, destination: Destination) where S : StringProtocol {
        self.destination = destination
        self.label = Text(title)
        self.isDetail = true
        self.bindingIsActive = nil
    }
    
    public init<S>(_ title: S, destination: Destination, isActive: Binding<Bool>) where S : StringProtocol {
        self.destination = destination
        self.label = Text(title)
        self.isDetail = true
        self.bindingIsActive = isActive
    }
    
    public init(_ titleKey: LocalizedStringKey, destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self.label = Text(titleKey)
        self.isDetail = true
        self.bindingIsActive = isActive
    }
    
    public init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable {
        self.destination = destination
        self.label = Text(titleKey)
        self.isDetail = true
        self.bindingIsActive = Binding {
            selection.wrappedValue == tag
        } set: { newValue in
            selection.wrappedValue =  newValue ? tag : nil
        }
    }
    
    public init<S, V>(_ title: S, destination: Destination, tag: V, selection: Binding<V?>) where S : StringProtocol, V : Hashable {
        self.destination = destination
        self.label = Text(title)
        self.isDetail = true
        self.bindingIsActive = Binding {
            selection.wrappedValue == tag
        } set: { newValue in
            selection.wrappedValue =  newValue ? tag : nil
        }
    }
}

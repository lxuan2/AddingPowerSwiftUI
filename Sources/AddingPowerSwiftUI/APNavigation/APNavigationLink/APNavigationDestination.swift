//
//  APNavigationDestination.swift
//  
//
//  Created by Xuan Li on 4/1/21.
//

import SwiftUI

struct APNavigationDestination<NavigationContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var isDetail: Bool
    var navigationContent: NavigationContent
    @Environment(\.apNVC) private var nvcBox
    @StateObject private var coordinator = Coordinator()
    
    func body(content: Content) -> some View {
        if let controller = coordinator.controller {
            controller.rootView = navigationContent
            controller.binding = $isPresented
        }
        return content
            .onChange(of: isPresented) { newValue in
                if newValue {
                    if let nvc = nvcBox.controller {
                        coordinator.controller = nvc.pushBridgedViewController(content: navigationContent, binding: $isPresented, animated: true)
                    } else {
                        isPresented = false
                    }
                } else {
                    coordinator.controller?.popFromNavigationController(animated: true)
                }
            }
            .onAppear {
                if coordinator.isInited {
                    if isPresented {
                        if let nvc = nvcBox.controller {
                            coordinator.controller = nvc.pushBridgedViewController(content: navigationContent, binding: $isPresented, animated: false)
                        } else {
                            isPresented = false
                        }
                    }
                    coordinator.isInited = false
                }
            }
    }
    
    class Coordinator: ObservableObject {
        weak var controller: APNavigationBridgedController<NavigationContent>?
        var isInited: Bool
        
        init() {
            controller = nil
            isInited = false
        }
    }
}

extension View {
    func apNavigationDestination<Destination: View>(_ destination: Destination, isPresent: Binding<Bool>, isDetail: Bool) -> some View {
        modifier(APNavigationDestination(isPresented: isPresent, isDetail: isDetail, navigationContent: destination))
    }
}

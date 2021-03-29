//
//  APNavigationLink.swift
//  
//
//

import SwiftUI

public struct APNavigationLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    @StateObject var coordinator = Coordinator()
    @Environment(\.apNVC) var nvc
    
    public var body: some View {
        updateViewController()
        return Button(action: pushViewController, label: { label })
    }
    
    private func pushViewController() {
        if coordinator.dvc == nil, let nvc = nvc.controller {
            let dvc = APNavigationBridgedController(rootView: destination, navigationController: nvc)
            coordinator.dvc = dvc
            nvc.pushViewController(dvc, animated: true)
        }
    }
    
    private func updateViewController() {
        if let dvc = coordinator.dvc {
            (dvc as! APNavigationBridgedController<Destination>).rootView = destination
        }
    }
    
    public init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    class Coordinator: NSObject, ObservableObject {
        weak var dvc: UIViewController? = nil
    }
}

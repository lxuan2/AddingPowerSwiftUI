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
    @Environment(\.apNavigationController) var navigationController
    
    public var body: some View {
        updateViewController()
        return Button(action: pushViewController, label: { label })
    }
    
    private func pushViewController() {
        if coordinator.dvc == nil, let nvc = navigationController.vc {
            let dvc = APNavigationPageController(rootView: destination)
            coordinator.dvc = dvc
            dvc.modalPresentationStyle = .overFullScreen
            dvc.view.alpha = 0
            dvc.view.isUserInteractionEnabled = false
            nvc.present(dvc, animated: false) {
                dvc.dismiss(animated: false) {
                    dvc.modalPresentationStyle = .automatic
                    dvc.view.alpha = 1
                    dvc.view.isUserInteractionEnabled = true
                    nvc.pushViewController(dvc, animated: true)
                }
            }
        }
    }
    
    private func updateViewController() {
        if let dvc = coordinator.dvc {
            (dvc as! APNavigationPageController<Destination>).wrappedRootView = destination
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

//
//  SwiftUIView.swift
//  
//
//  Created by Xuan Li on 1/21/21.
//

import UIKit

public class APNavigationController: UINavigationController, ObservableObject {
    public var rootID: UUID?
    public var rootLocation: [APPath]?

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBar.prefersLargeTitles = true
    }


}

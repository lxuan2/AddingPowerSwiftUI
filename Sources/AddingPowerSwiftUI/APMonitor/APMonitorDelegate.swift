//
//  APMonitorDelegate.swift
//  Navigation
//
//  Created by Xuan Li on 2/6/21.
//

import SwiftUI

public protocol APMonitorDelegate {
    func updateViews(from previous: [APAnySynView], to current: [APAnySynView])
}

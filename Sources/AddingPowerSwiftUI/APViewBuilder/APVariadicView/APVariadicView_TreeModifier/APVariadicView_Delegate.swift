//
//  APVariadicView_Delegate.swift
//  
//
//  Created by Xuan Li on 2/12/21.
//

import SwiftUI

public protocol APVariadicView_Delegate {
    func viewList(_ viewList: [APAnySynView], willReplace range: Range<Int>, with views: [APAnySynView])
    func viewList(_ viewList: [APAnySynView], didReplace range: Range<Int>, with views: [APAnySynView])
    func initial(_ viewList: [APAnySynView])
}

public extension APVariadicView_Delegate {
    func viewList(_ viewList: [APAnySynView], willReplace range: Range<Int>, with views: [APAnySynView]) {}
    func viewList(_ viewList: [APAnySynView], didReplace range: Range<Int>, with views: [APAnySynView]) {}
    func initial(_ viewList: [APAnySynView]) {}
}

public protocol APVariadicView_PrimitiveDelegate {
    func subRoot(subRoot: APVariadicView_Root, willUpdate newViewRoot: [APVariadicView], in root: APVariadicView_Root)
    func subRoot(subRoot: APVariadicView_Root, didUpdate newViewRoot: [APVariadicView], in root: APVariadicView_Root)
    func initial(_ root: APVariadicView_Root)
}

public extension APVariadicView_PrimitiveDelegate {
    func subRoot(subRoot: APVariadicView_Root, willUpdate newViewRoot: [APVariadicView], in root: APVariadicView_Root) {}
    func subRoot(subRoot: APVariadicView_Root, didUpdate newViewRoot: [APVariadicView], in root: APVariadicView_Root) {}
    func initial(_ root: APVariadicView_Root) {}
}

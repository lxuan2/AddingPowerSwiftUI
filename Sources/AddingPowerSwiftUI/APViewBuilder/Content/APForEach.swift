//
//  APForEach.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

public struct APForEach<Data, ID, Content> where Data : RandomAccessCollection, ID : Hashable, Content : View {
    private var _body: ForEach<Data, ID, Content>
    private var id: (Data.Element) -> ID
    @StateObject private var viewRoot = APVariadicView_MultiViewRoot(env: .identifiable)
    @EnvironmentObject var coordinator: APVariadicView.CoordinatorBase
}

extension APForEach : APView {
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                _body
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.viewRootModification(viewRoot, $0, _body.data.map(id))
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
}

extension APForEach where ID == Data.Element.ID, Data.Element : Identifiable {
    public init(_ data: Data, @APViewBuilder content: @escaping (Data.Element) -> Content) {
        self._body = ForEach(data, content: content)
        self.id = { $0.id }
    }
}

extension APForEach {
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @APViewBuilder content: @escaping (Data.Element) -> Content) {
        self._body = ForEach(data, id: id, content: content)
        self.id = { $0[keyPath: id] }
    }
}

extension APForEach where Data == Range<Int>, ID == Int {
    public init(_ data: Range<Int>, @APViewBuilder content: @escaping (Int) -> Content) {
        self._body = ForEach(data, content: content)
        self.id = { $0 }
    }
}

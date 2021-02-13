//
//  APForEach.swift
//  
//
//  Created by Xuan Li on 2/13/21.
//

import SwiftUI

public struct APForEach<Data, ID, Content> where Data : RandomAccessCollection, ID : Hashable, Content : View {
    public var data: Data
    public var content: (Data.Element) -> Content
    private var _body: ForEach<Data, ID, Content>
    @StateObject private var viewRoot = APVariadicView_Root()
    @EnvironmentObject private var coordinator: APVariadicView.CoordinatorBase
}

extension APForEach : APView {
    public var body: some View {
        APIDView(id: viewRoot.id) {EmptyView()}.equatable()
            .overlay(
                _body
                    .onPreferenceChange(APVariadicView_PreferenceKey.self) {
                        coordinator.replace(viewRoot: $0, in: viewRoot, atrribute: .any)
                    }
            )
            .preference(key: APVariadicView_PreferenceKey.self, value: [.multi(viewRoot)])
    }
}

extension APForEach where ID == Data.Element.ID, Data.Element : Identifiable {
    public init(_ data: Data, @APViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
        self._body = ForEach(data, content: content)
    }
}

extension APForEach {
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @APViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
        self._body = ForEach(data, id: id, content: content)
    }
}

extension APForEach where Data == Range<Int>, ID == Int {
    public init(_ data: Range<Int>, @APViewBuilder content: @escaping (Int) -> Content) {
        self.data = data
        self.content = content
        self._body = ForEach(data, content: content)
    }
}

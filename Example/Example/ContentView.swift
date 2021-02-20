//
//  ContentView.swift
//  Example
//
//  Created on 2/20/21.
//

import SwiftUI
import AddingPowerSwiftUI

struct ContentView: View {
    @State private var rootPage = false;
    @State private var childRootPage = false;
    @State private var rootTitle = false;
    @State private var childTitle = false;
    @State private var hideBar = false
    @State private var hideRoot = false
    @State private var views: [APAnyUniqueView] = []
    
    var body: some View {
        VStack(spacing: 0) {
            APNavigationView {
                if !hideRoot {
                    mainView
                }
                if #available(iOS 14.0, *) {
                    Text("IOS 14")
                }
                Color.blue.opacity(0.1)
            }.apNavigationViewStyle(APStackNavigationViewStyle())
            
            APVariadicView.Tree(root: MyViewRoot(), content: children)
            
            controlPanel
        }
    }
    
    var mainView: some View {
        Form {
            if rootPage {
                Text("Hello, world!")
                    .padding()
            } else {
                Image(systemName: "pencil")
            }
            APNavigationLink(destination: nextView) {
                Text("Link")
            }
        }
        .apNavigationTitle(rootTitle ? "Adv Root" : "Root")
        .apNavigationBarTitleDisplayMode(.inline)
        .apNavigationBarHidden(hideBar)
    }
    
    var nextView: some View {
        Form {
            APNavigationLink(destination: nextnextView) {
                ZStack {
                    if childRootPage {
                        Text("final")
                    } else {
                        Text("new Final")
                    }
                }
            }
        }
        .apNavigationTitle{childTitle ? Text("inter").font(.largeTitle).fixedSize() : Text("outer").bold().fixedSize()}
        .apNavigationBarTitleDisplayMode(.inline)
    }
    
    var nextnextView: some View {
        Form {
            Text("Final")
        }
        .apNavigationPrompt("Hint")
        .apNavigationTitle("final")
        .apNavigationBarTitleDisplayMode(.large)
    }
    
    var controlPanel: some View {
        Form {
            Button("rootTitle") {
                rootTitle.toggle()
            }
            
            Button("rootPageContent") {
                rootPage.toggle()
            }
            
            Button("childTitle") {
                childTitle.toggle()
            }
            
            Button("childPageContent") {
                childRootPage.toggle()
            }
            
            Toggle(isOn: $hideBar) {
                Text("Hide bar")
            }
            
            Toggle(isOn: $hideRoot) {
                Text("Hide root")
            }
        }
    }
    
    @APViewBuilder var children: some APView {
        if #available(iOS 14.0, *) {
            Text("IOS 14")
        }
        
        APGroup {
            Text("0")
            if rootTitle {
                Text("1")
            }
            else {
                Text("2")
                if rootPage {
                    Text("3")
                    
                } else {
                    Text("4")
                }
            }
        }
        
        APForEach(0..<2) {
            if childTitle {
                Text("\($0)")
            }
            Text("|")
        }
        
        Color.red
        Color.green
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct MyView: View {
    @State private var views: [APAnyUniqueView] = []
    let configuration: APVariadicViewConfiguration
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(views) { v in
                    v
                }
            }.frame(width: UIScreen.main.bounds.size.width, height: 30)
        }
        .padding(.vertical)
        .background(
            ZStack {
                Color.primary.opacity(0.2).blur(radius: 5)
                Color("adaptiveColor")
            }.edgesIgnoringSafeArea(.all)
        )
        .zIndex(1)
        .onReceive(configuration.onInit, perform: {
            views = $0
        })
        .onReceive(configuration.onReplace, perform: {
            var newList = $0.0
            newList.replaceSubrange($0.1, with: $0.2)
            views = newList
        })
        .onReceive(configuration.onModification, perform: {
            var newList = $0.0
            newList.replaceSubrange($0.1, with: $0.2)
            views = newList
        })
    }
}

struct MyViewRoot: APVariadicView_Root {
    func makeBody(configuration: APVariadicViewConfiguration) -> some View {
        MyView(configuration: configuration)
    }
}


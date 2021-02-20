# AddingPowerSwiftUI

An extensional package for SwiftUI, which adds some missing APIs like a parsable `ViewBuilder`. 

## Status
Still in development. Documentation will be added. 
Currently `APNavigationView` fully uses `APViewBuilder` for the root view. `APStackNavigationViewStyle` uses view transfer and `APStyle`. There is an example project showing some basic usage.

## Motivation
`SwiftUI` is an awesome framework that uses simple and clean declarative programming paradigms. However, it's closed source framework and we do not have the full control to the underlying functionality. This makes it hard to create clean APIs like the original. For example, when creating a container view like this:
```Swift
APTabView {
    View1()
    View2()
    View3()
}
```
we found that no public APIs can be used to parse the view  `TupleView<(View1, View2, View3)>`. On the contrast, primitive types like `ZStack` and `NavigationView` use `_VariadicView.Tree` to manage the structure inside the `SwiftUI` framework. The `SwiftUI.swiftmodule/arm64.swiftinterface` file shows more details about the hidden public APIs.

Therefore, this package aims to achieve following requirements to make `APViewBuilder` behave like native APIs:
* able to handle any input type like `TupleView<(Text, Image)>` and `TupleView<(View1, View2, View3)>`
* allow conditional statements like `if` and `switch`
* high efficiency. We don't want everything becomes `AnyView` or views get updated for unrelated changes. Only modified content needs update.

The main trick is the type erasing by `UIHostingView<V> -> UIViewController` and wrapping the it into a struct to pass through the view hierarchy. As a result, we only install a `View` or `UIViewController` once. Later, it updates itself without any addtional work. In other word, monitor a view in its original decleared place but use it anywhere we want.

A final result like this should work properly.
```
@APViewBuilder var demoView: some APView {
    Text("First Item")
    if #available(iOS 14.0, *) {
        Text("IOS 14")
    }
    APGroup {
        Text("0")
        if isOne {
            Text("1")
        }
        else {
            Text("2")
            if isThree {
                Text("3")
                
            } else {
                Text("4")
            }
        }
    }
    APForEach(0..<2) {
        if shouldShowContent {
            Text("\($0)")
        }
        Divider()
    }
    Color.green
}
```

This package tries to reimplement some native APIs like `NavigationView` and `TabView` to discover all the need. Some handy APIs like view transfer are provided. (Sometimes we declear an view in some place but we don't want to use it right there, for example,`.tabItem()`. Therefore, we would like to transfer it like other preference content). 

In all, `AddingPowerSwiftUI` is created to provide more control for developers to `SwiftUI` framework.

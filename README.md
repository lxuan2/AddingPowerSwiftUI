# AddingPowerSwiftUI

An extensional package for SwiftUI, which adds some missing APIs like parsable `ViewBuilder`. 

## Status
Still in development.

## Motivation
`SwiftUI` is an awesome framework that uses simple and clean declarative programming paradigms. However, it's Apple's closed source framework. Developers don't have the full control to the underlying functionality. This makes it hard to create clean APIs like the original. For example, create a container view like this:
```Swift
APTabView {
    View1()
    View2()
    View3()
}
```
Digging into the implementation, you will realize that there is no API to parse the input view like `TupleView<(View1, View2, View3)>`! How can I manage these views individually? As we know, the primitive types like `ZStack` and `List` have this ability inside the `SwiftUI` internel framework. But Apple hides them for some reasons. If you dig into it and look at the `.swiftinterface` file for `SwiftUI`, you know Apple uses `_VariadicView.Tree` to manage the relationship between the root container view (like `ZStack`) and its input view.

Therefore, we wonder we can interpret the view manually. There are several requirements.
* correctness
* clean like native APIs
* generic to handle any input type like `TupleView<(Text, Image)>` and `TupleView<(View1, View2, View3)>`
* allow conditional statements like `if` and `switch`
* high efficiency. We don't want everything becomes `AnyView` or every views get updated for unrelated changes.  Only modified content needs update.

This package achieves these goals in a very efficient way and it seems likes native APIs. No complicated usage. Only replace `@ViewBuilder` with `@APViewBuilder` for the input view. To interpret it inside the container view, just attach `.monitorViews(inputView, APMonitorDelegate)` to a view and implement the delegate to get a list of parsed views. No worry to view content updates, since they update themselves. If views are added or removed, the delegate you provide can handle them. For more implementation details, refer to the documentation for `@APViewBuilder`.

`AddingPowerSwiftUI` also provide other missing handy APIs like `Style` and customizable `APNavigationView`. This is a similar behavior to `StackNavigationViewStyle` and `DoubleColumnNavigationViewStyle` but allows building your own view styles.

In all, `AddingPowerSwiftUI` is created to provide more control for developers to `SwiftUI` framework.

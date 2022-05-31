# SwiftyOnAppear

`SwiftyOnAppear` provides you several functions that can used in the SwiftUI. It provides the `UIKit` view life circle functions.

## How to use

```swift
Text("Hello, world!")
    .padding()
    .viewDidLoad {
        print("viewDidLoad")
    }
    .viewWillDisappear { animated in
        print("viewWillDisappear", animated)
    }
    .viewDidDisappear { animated in
        print("viewDidDisappear", animated)
    }
    .viewWillAppear { animated in
        print("viewWillAppear", animated)
    }
    .viewDidAppear { animated in
        print("viewDidAppear", animated)
    }
    .viewDidLayoutSubviews {
        print("viewDidLayoutSubviews")
    }
    .viewWillLayoutSubviews {
        print("viewWillLayoutSubviews")
    }
```

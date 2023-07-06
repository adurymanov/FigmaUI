# FigmaUI

FigmaUI is a framework for rendering figma documents in your application using UIKit elements.

## Usage

Only usage from figma API available now. 

Figma API key available on [this page](https://www.figma.com/developers/api#get-files-endpoint).
Document ID could be found in document url: "https://www.figma.com/file/{Document ID}" 

```swift
import FigmaUI

let figmaViewController = FigmaViewController(
    apiKey: "<Figma API key>",
    documentId: "<Figma document id>"
) { document in
    document.firstView(withName: "<Figma view name>")
}
```

## Adding FigmaUI as a Dependency

To use the FigmaUI library in a SwiftPM project, add the following line to the dependencies in your Package.swift file:

```swift
.package(url: "https://github.com/apple/swift-async-algorithms"),
```

Include "FigmaUI" as a dependency for your executable target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "FigmaUI", package: "FigmaUI"),
]),
```

Finally, add import FigmaUI to your source code.

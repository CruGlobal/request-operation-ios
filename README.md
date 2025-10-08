[![codecov](https://codecov.io/gh/CruGlobal/request-operation-ios/branch/main/graph/badge.svg)](https://codecov.io/gh/CruGlobal/request-operation-ios)

RequestOperation
================

A swift package to facilitate in creation of URLRequests (RequestBuilder) and provides an Operation (RequestOperation) for submitting requests from an OperationQueue.  Completed RequestOperations will provide a RequestResponse object with some details about the completed request. 

- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Publishing New Versions With GitHub Actions](#publishing-new-versions-with-github-actions)
- [Publishing New Versions Manually](#publishing-new-versions-manually)

### Basic Usage

- Use RequestBuilder to build URLRequests

```swift
let urlRequest: URLRequest = RequestBuilder().build(
    parameters: RequestBuilderParameters(
        urlSession: urlSession,
        urlString: "url-here",
        method: .get,
        headers: nil,
        httpBody: nil,
        queryItems: nil
    )
)
```

- Use RequestSender to send URLRequests

```swift
let requestSender = RequestSender()

return requestSender.sendDataTaskPublisher(
     urlRequest: urlRequest,
     urlSession: urlSession
)
.map { (response: RequestDataResponse) in
    // Do something with response...
}
.eraseToAnyPublisher()
```

### Advanced Usage

### Publishing New Versions With GitHub Actions

Publishing new versions with GitHub Actions build workflow.

- Ensure a new version is set in the VERSION file.  This can be set manually or by manually running the Create Version workflow.

- Create a pull request on main and once merged into main GitHub actions will handle tagging the version from the VERSION file.

### Publishing New Versions Manually

Steps to publish new versions for Swift Package Manager. 

- Set the new version number in the VERSION file.

- Tag the main branch with the new version number and push the tag to origin.

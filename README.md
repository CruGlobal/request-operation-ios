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

Publishing new versions with GitHub Actions is easy.

- Ensure you set a new version in RequestOperation.podspec.  The new version can't already exist as a tag.
- Create a pull request on main and once merged into main GitHub actions will handle tagging the version and pushing to the CruGlobal specs repo.

### Publishing New Versions Manually

Steps to publish new versions for Cocoapods and Swift Package Manager. 

- Edit RequestOperation.podspec s.version to the newly desired version following Major.Minor.Patch.

- Run command 'pod lib lint RequestOperation.podspec' to ensure it can deploy without any issues (https://guides.cocoapods.org/making/using-pod-lib-create.html#deploying-your-library).

- Merge the s.version change into the main branch and then tag the main branch with the new version and push the tag to remote (Swift Package Manager relies on tags).  

- Run command 'pod repo push cruglobal-cocoapods-specs RequestOperation.podspec' to push to CruGlobal cocoapods specs (https://github.com/CruGlobal/cocoapods-specs).  You can also run command 'pod repo list' to see what repos are currently added and 'pod repo add cruglobal-cocoapods-specs https://github.com/CruGlobal/cocoapods-specs.git' to add repos (https://guides.cocoapods.org/making/private-cocoapods.html).


Cru Global Specs Repo: https://github.com/CruGlobal/cocoapods-specs

Private Cocoapods: https://guides.cocoapods.org/making/private-cocoapods.html

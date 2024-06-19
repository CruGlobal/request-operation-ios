RequestOperation
================

A swift package to facilitate in creation of URLRequests (RequestBuilder) and provides an Operation (RequestOperation) for submitting requests from an OperationQueue.  Completed RequestOperations will provide a RequestResponse object with some details about the completed request. 

- [Publishing New Versions With GitHub Actions](#publishing-new-versions-with-github-actions)
- [Manually Publishing New Versions](#manually-publishing-new-versions)

### Publishing New Versions With GitHub Actions

Publishing new versions with GitHub Actions is easy.

- Ensure you set a new version in RequestOperation.podspec.  The new version can't already exist as a tag.
- Create a pull request on main and once merged into main GitHub actions will handle tagging the version and pushing to the CruGlobal specs repo.

### Manually Publishing New Versions

Steps to publish new versions for Cocoapods and Swift Package Manager. 

- Edit RequestOperation.podspec s.version to the newly desired version following Major.Minor.Patch.

- Run command 'pod lib lint RequestOperation.podspec' to ensure it can deploy without any issues (https://guides.cocoapods.org/making/using-pod-lib-create.html#deploying-your-library).

- Merge the s.version change into the main branch and then tag the main branch with the new version and push the tag to remote (Swift Package Manager relies on tags).  

- Run command 'pod repo push cruglobal-cocoapods-specs RequestOperation.podspec' to push to CruGlobal cocoapods specs (https://github.com/CruGlobal/cocoapods-specs).  You can also run command 'pod repo list' to see what repos are currently added and 'pod repo add cruglobal-cocoapods-specs https://github.com/CruGlobal/cocoapods-specs.git' to add repos (https://guides.cocoapods.org/making/private-cocoapods.html).


Cru Global Specs Repo: https://github.com/CruGlobal/cocoapods-specs

Private Cocoapods: https://guides.cocoapods.org/making/private-cocoapods.html
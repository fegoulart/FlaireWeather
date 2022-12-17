# FlaireWeather Challeng 

## Architecture
* [Clean Architecture Based](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) 
* UI pattern: MVP with Adapter conforming to ViewDelegate 

### MVP with Adapter conforming to ViewDelegate
* View delegates messages via a protocol
* Adapter conforms to ViewDelegate and translates event to Domain requests/commands
* Presenter holds a reference to an Abstract View type in the form of a protocol
* Example diagram:

[MVP example diagram](https://www.filepicker.io/api/file/SYyWMPykTPEoQxqvz4j2)

### Some Design Patterns present in project:
* Adapter
* Decorator
* Delegate
* Factory
* Mapper
* Proxy

### Implementation details
* Network implemented with URLSession
* Image download and cache implemented with Kingfisher
* UI with UIKit + ViewCode

## Dependencies
* [Kingfisher](https://github.com/onevcat/Kingfisher) - Image download and cache

## Requirements
* XCode 14
* iOS 15.0

### Possible improvements:

* [Tuist Implementation](https://tuist.io)
* Weather Caching + Fallback (not only for image) 
* Automatic build / deploy pipeline (e.g.: Fastlane) 
* Add an app icon 
* Dark mode
* Implement accessibility features
* Ipad / MacOS / WatchOs version
* Better test coverage
* Replace Kingfisher with custom module (no external library dependency)
* Add Swiftlint script
* Modular design (create separate projects)
* Localization (text translation)

# Marvel Project
This project aims to consume data from [Marvel API](https://developer.marvel.com) in order to present two screens: Characters list and Character detail.

## Requirements
* iOS 13.2

## Structure
Marvel Project is composed by these main artifacts:

Components  | Main Responsability
----------- | -------------------
[AppCoordinator](https://github.com/lmbcosta/MarvelProject/blob/master/MarvelProject/Coordinator/AppCoordinator.swift) | Instantiates dependencies and handles navigation
View Controllers| Builds and controls different UI components for both screens
DataSources            | Manages data and feeds content for table view cells
ViewModels | Prepares content, and manages business logic, such as network request pagination
[MarvelService](https://github.com/lmbcosta/MarvelProject/blob/master/MarvelProject/Service/MarvelService.swift) | Manages network calls to Marvel API

## External Dependencies ✅
Marvel Project has **2** external depencies:</p>
**[KingFisher](https://github.com/onevcat/Kingfisher)**: A lightweight, pure-Swift library for downloading and caching images from the web. It was decided to use it to cache and download all Marvel character's images.</p>

**[CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)**: A growing collection of standard and secure cryptographic algorithms implemented in Swift. Marvel API requires a md5 hash of some components as a query parameter. Creating a md5 hash function is not a trivial thing so it was decided to use one from a popular open source crypto library instead of trying a new implementation.</p>

#### Dependency Manager
As dependency manager it was used Swift Package Manager (SPM).

## Tests: 
#### Unit Tests ✅
This project is covered with 24 unit tests divided for different layers, being UI layer an exception.
You can check them [here](https://github.com/lmbcosta/MarvelProject/tree/master/MarvelProjectTests/UnitTests). 

## Last Considerations
Due to a lack of time, there are some things that should be improved:
- Layout was terrible. I would like to be able to focus more on this subject.
- Try to cover UI layer with more unit tests.
- Use and abuse of Marvel API data, there is so much content that definitely I could use it to improve the app.
- Proper way to declare private keys on client side. The private key used for Marvel API is hardcoded. I am not confortable with that but for the sake of this exercise I left as it is. I looked up for some approaches such as [this one](https://nshipster.com/secrets/#universe-brain-client-secrecy-is-impossible).

## Author
Luís Costa - lmbcosta@hotmail.com

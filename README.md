# Dogbreeds

## Overview
This app was developed for the technical screening for the position of iOS developer in Shape.

The app includes three Swift Local Frameworks: Data, Domain and Injector. The first two are to have a Clean Architecture implementation, meaning the segregation of Information Providers, Entities, Models and Use cases to it's correspondant layer. And the last one (Injector) is a customized solution (and also very simple) for injecting dependencies.

This Injection framework uses a common and well known technic in the iOS community of playing with a Dependency Container which keeps references to dependencies that can be injected when asked, along with a property wrapper @Injected for an easy accesor to these dependencies. Of course such a common and simple solution comes with cons, but for this exercise it was considered enough by the author

## How to run
Thinking in maintaince the project uses xcodegen, thus you will find a project.yml at root level, so to generate xcodeproj file just run in your terminal command `xcodegen` (if you don't have it installed follow instructions at: https://github.com/yonaskolb/XcodeGen).

It's possible that the first time you try to run the project, it won't compile, as the main project depends on the frameworks of Data, Domain and Injector, however if you find that issue, please make sure to build the targets in the following order:

Data
Domain
Injector
DogBreeds

 ## App architecture
The app uses a Clean Architecture along with a MVVM approach, meaning that we have three different layers:

Data: This layer is in charge of having the data providers and data models that will be used for the app. It can be seen as a Data Source, meaning that it will be from this layer that the app will be fetching information, regardless of the nature of the information requested (local or remote).
This layer has a Core Data Model which stores information locally, it also has a Network manager, which is responsible for fetching remote information via URLSession and attempting to get a successful response which can be parsed into entities that will be used by the app.

It also defines providers to have as accessors to information that's locally stored or needs to be fetched via a service. And finally it contains the data structures (Entities) that will be parsed into models in the Domain layer so they can be used by the Presentarion layer to render teh different states and elements that the app needs.

Domain: This is the the layer where most of the Business Logic is allocated into smaller pieces of code called as Use Cases, which are specific units of logic for processing a given task.
For instance there is a use case for fetching information via a URLSession and if successful, storing the parsed entities into Core Data Models.

This layer also has a "Model" definition which is a mapping of a Data entity, and thus achieving a desirable isolation between the real and authentic data and the ones used for the layout of the views, avoiding unwanted side effects in the data sources.

Presentation: This is the layer where all the views are, and the layout, gestures observations, inputs listenings, (...) is.
This layer uses a MVVM architecture, which was the decision that the author made, considering that app uses SwiftUI.

The flow of the app is the normal of a MVVM architecture: The View Model is sesponsible of business logic, by invoking use cases and updating the view state. The view listens to changes of ViewModel state and reacts accordingly.

## Unit tests
All layers include unit tests, but the ones with more coverage are Data and Domain. 

So please take a look at all the tests and please also make sure to take a look at tests for ViewModel that use Use Cases as you will find something at least curious with the Injector developed for this project (nothing fancy but worthy of being mentioned).

# MVC [ref](https://medium.com/upday-devs/android-architecture-patterns-part-1-model-view-controller-3baecef5f2b6)

## Layer definition
* Model — the data layer, responsible for managing the business logic and handling network or database API.
* View — the UI layer — a visualisation of the data from the Model.
* Controller — the logic layer, gets notified of the user’s behavior and updates the Model as needed.

## Layer behavior
* Controller depends on Model
* View depends on Model
* Controller writes Model -> Controller notify View -> View fetch Model (Passive model mode)
* View observe Model -> Controller writes Model -> View get event from Model and fetch Model (Passive model mode)

## Android scenario
* In android, the Activities, Fragments and Views should be the Views in the MVC world. The Controllers should be separate classes that don’t extend or use any Android class, and same for the Models
* But then, we end up with Models that handle both business and UI logic. It would be unit testable, but then the Model ends up, implicitly being dependent on the View

# MVP

## Layer definition
* Model — the data layer. Responsible for handling the business logic and communication with the network and database layers.
* View — the UI layer. Displays the data and notifies the Presenter about user actions.
* Presenter — retrieves the data from the Model, applies the UI logic and manages the state of the View, decides what to display and reacts to user input notifications from the View.

# MVVM

## Layer definition
(Data)Model — abstracts the data source. The ViewModel works with the DataModel to get and save the data.
View — that informs the ViewModel about the user’s actions
ViewModel — exposes streams of data relevant to the View

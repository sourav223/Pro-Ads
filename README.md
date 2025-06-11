# Pro-Ads

This is a SwiftUI application designed to display a collection of advertisements fetched from a remote JSON API. Users can browse all available ads, mark them as favorites, and then switch to a view that displays only their favorited ads, which are available for offline viewing.

## Solution Description

The application is built using **SwiftUI** for the user interface and **Combine** for reactive programming and asynchronous operations, particularly for network requests.

Key components include:

* **`Ad` Models:** Swift `Codable` structs that mirror the structure of the incoming JSON data, with careful consideration for optional properties to ensure robust decoding.

* **`APIHandeler`:** Handles fetching ad data from the provided remote JSON URL using `URLSession.shared` and Combine's `dataTaskPublisher`. It includes custom error handling for network and decoding failures.

* **`FavoriteManager`:** An `ObservableObject` responsible for managing the favorited ads. It stores the full `Ad` JSON data in `UserDefaults` for persistence, allowing offline access to favorited items.

* **`AdListViewModel`:** An `ObservableObject` that acts as the central state manager for the main view. It orchestrates data fetching, filters ads based on the "all" or "favorites only" selection, and exposes loading and error states to the UI.

* **`ContentView`:** The main SwiftUI view that ties everything together, providing a segmented control for filtering and displaying the ads in a `List`.

* **`AdCellView`:** A reusable SwiftUI view component for displaying individual ad details (photo, description, location, price) and a toggleable favorite button. **`AsyncImage`** is used for efficient image loading and caching.

## What I'm Particularly Proud Of

* **Robust `Codable` Implementation:** The `Ad` models are meticulously designed with optional properties and custom `CodingKeys` (`ad-type` to `adType`) to handle potential variations and `null` values in the remote JSON, preventing decoding crashes.

* **Efficient Image Loading:** The integration of `AsyncImage` in `AdCellView` provides built-in caching, preventing unnecessary reloads of images when scrolling back and forth, which significantly enhances scrolling performance and user experience.

* **Clear Separation of Concerns:** The architecture clearly separates networking (`APIHandeler`), data persistence (`FavoriteManager`), business logic (`AdListViewModel`), and UI (`ContentView`, `AdCellView`), leading to a more maintainable and testable codebase.

* **Combine for Concurrency:** Leveraging Combine for asynchronous operations (network fetching, state observation) makes the data flow reactive and easier to manage, reducing callback hell and improving readability.

## What Could Have Been Done Better

* **More Granular Error States:** While basic error messages are shown, a more user-friendly and actionable error handling strategy could be implemented (e.g., specific error types for network issues vs. server errors, visual cues for individual failed image loads).

* **Offline Data Handling (Beyond Favorites):** The current offline support is limited to favorited ads. A more comprehensive offline strategy could involve caching all fetched ads for a certain period, allowing browsing even when the network is unavailable.

* **User Interface Polishing:** While functional, the UI could benefit from more refined styling, animations, and potentially a custom design system to align with a specific brand identity.

## What Else Could Have Been Done with More Time

* **Search and Filtering:** Implement a search bar to allow users to search for ads by title, description, or location. Additional filtering options (e.g., by price range, ad type) could also be added.

* **Sorting Options:** Allow users to sort the ad list by various criteria such as price, score, or location.

* **Detailed Ad View:** Create a dedicated detail screen for each ad that displays more comprehensive information, larger images, and perhaps map integration for the location.

* **Pull-to-Refresh:** Implement a pull-to-refresh mechanism for the ad list to allow users to manually trigger a data reload.

* **Unit and UI Testing:** Comprehensive unit tests for `APIHandeler`, `FavoriteManager`, and `AdListViewModel`, as well as UI tests for `ContentView` and `AdCellView`, would greatly improve code quality and ensure stability.

* **Dependency Injection:** A more robust dependency injection system could be implemented for `APIHandeler` and `FavoriteManager` into `AdListViewModel` to facilitate easier testing and modularity.

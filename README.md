# 📋 State of the Application

- **User fetch** is working, but there is a bug where some users can be loaded several times.
- **Story loading** works from remote and is saved in the database, but when we launch the app again, the fetch of the image with the URL saved in SwiftData does not work.
- **Pagination** is implemented on users but not on stories.
- **Story state** is not persisted in the database.

# 🏗️ Architecture

The project is separated into three parts (fictive Swift packages):

- **SharedPackage**:  
  Contains all domain definitions and data repository protocols.
  
- **ServicePackage**:  
  Contains all the fetch logic for users and stories.
  
- **FeaturePackage**:  
  Contains the UI logic.

# 💬 Remarks

- I didn't have time to create the actual Swift packages for **Shared**, **Service**, and **Feature** for modularization.
- I wanted to use **CoreData** to persist stories' information, but I had a bug with Xcode that would duplicate the model and CoreData types, so I went with **SwiftData** (first time using it).
- I wanted to implement **story state saving** in SwiftData through a repository, but didn't have time.
- Even if there are only two screens, the **navigation logic** should be encapsulated in a **Coordinator** object.
- I didn't have time to add **unit** and **integration tests**, but the logic is testable thanks to the **dependency injection** pattern (repositories can be mocked in view models).
- I tried to use the **Observation API**, but I encountered a bug where view redraw would not be triggered, so I fallbacked to **ObservableObject**.
- There are a lot of **hardcoded values** that could be centralized in a dedicated **Constants** structure.

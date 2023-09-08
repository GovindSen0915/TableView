# TableView

Tableview Light Mode    |  Tableview Dark Mode
:-------------------------:|:-------------------------:
<Simulator Screenshot - iPhone 14 Pro - 2023-09-08 at 23.27.45.png">|<Simulator Screenshot - iPhone 14 Pro - 2023-09-08 at 23.27.51.png">

- **Purpose**: This Swift code is designed to create a basic iOS application that displays data in a table view using the MVVM (Model-View-ViewModel) architectural pattern.

- **Components**:
  - **ViewController**: Represents the view layer of the application.
    - Manages a `tableView` for displaying data.
    - Has a `viewModel` property that conforms to `ViewControllerProtocol`.
    - Loads data into the table view when the view loads.
    - Implements `ViewModelProtocol` to handle updates from the view model.
    
  - **ViewModel**: Represents the view model layer responsible for data management.
    - Conforms to `ViewControllerProtocol`.
    - Stores data in `sectionModels` and `cellModels`.
    - Prepares and manages data in the `prepareCellModel` method.
    - Initializes data using `setupData`.
    - Implements `ViewModelProtocol` to communicate updates to the view controller.

- **Protocols**:
  - **ViewControllerProtocol**: Defines methods for the view controller to communicate with the view model, such as retrieving the number of sections, number of items in a section, and individual items.
  - **ViewModelProtocol**: Defines methods for the view model to communicate with the view controller, primarily for reloading the view when data changes.

- **UITableViewDataSource and UITableViewDelegate**: The view controller conforms to these protocols to handle table view data source and delegate methods, populating the table view with data from the view model.

- **CustomCellModel and CustomCell**: These are expected to be custom data models and a custom UITableViewCell subclass used to represent data in each table view cell.

- **Design Pattern**: The code follows the MVVM design pattern, which promotes separation of concerns between the view (ViewController), data management (ViewModel), and protocols for communication between them.

This code can serve as a starting point for building iOS applications that display data in a structured manner within a table view while maintaining a clean separation of responsibilities between different architectural components.

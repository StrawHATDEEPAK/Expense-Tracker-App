# Expense Tracker App

A **Personal Expense Tracker** mobile application built using **Flutter**. The app helps users keep track of their daily, weekly, and monthly expenses with reminders to log expenses regularly. It uses **Firebase Firestore** for cloud storage and user authentication, while **Sqflite** is used for local data persistence. The app follows **Clean Architecture** principles and utilizes **Provider** for state management. Additionally, the app supports local notifications to remind users to log their expenses and is fully tested with unit tests covering the business logic.

## Features

- **User Authentication**: 
  - Sign up, log in, and log out functionality using Firebase Authentication.
  
- **Expense Management**:
  - Add, update, and delete expenses.
  - Store expenses both locally (using **Sqflite**) and remotely (using **Firebase Firestore**).
  - Daily, weekly, and monthly expense summaries.
  
- **Local Notifications**:
  - Reminds users to log expenses once a day.

- **Offline Support**:
  - All expenses are stored locally using Sqflite, allowing offline access.
  - Sync with Firebase Firestore when the user logs in or local data is missing.

- **Clean Architecture**:
  - Separation of concerns via layers: 
    - **Presentation**: UI and state management using **Provider**.
    - **Domain**: Business logic and use cases.
    - **Data**: Repositories, local and remote data sources.

- **Unit Testing**:
  - Business logic tested with unit tests, ensuring reliability of key use cases such as adding and retrieving expenses.

## Technology Stack

- **Flutter**: Cross-platform mobile framework.
- **Firebase Authentication**: Secure user authentication.
- **Firebase Firestore**: Cloud-based NoSQL database for storing user-specific expense data.
- **Sqflite**: Local database for offline data persistence.
- **Provider**: State management.
- **Clean Architecture**: Ensures separation of concerns for scalable and maintainable code.
- **Local Notifications**: Reminders for users to log expenses.


## Features

### 1. Add Expense
- Users can add a new expense entry.
- Expense data is saved locally (using SQLite) and remotely (Firestore) if the user is logged in.

### 2. View Expenses
- Fetch and display expenses from local storage when offline.
- Sync expenses with Firestore when logged in.
- View expenses summarized by daily, weekly, and monthly categories.

### 3. Update Expense
- Modify an existing expense entry.
- Changes are synced both locally and remotely to Firestore.

### 4. Delete Expense
- Users can delete an expense from both local storage and Firestore.

### 5. User Authentication
- User sign-up, login, and logout functionality.
- Data synchronization between local storage and Firestore happens once the user logs in.

### 6. Expense Summaries
- Generate summaries of daily, weekly, and monthly expenses.
- Visual breakdown of spending categories.

### 7. Local Notifications
- Daily notifications to remind users to log their expenses.
- Reminders are set via Flutter's local notification plugin.

## Tests

### 1. Unit Tests
- Test core business logic, such as adding, fetching, and updating expenses.
- Ensure proper working of use cases and the business layer.

### 2. Mocking
- Mocks are used to isolate the business logic from the data sources (local storage and Firestore).
- Only domain layer functionalities are tested using mocked data sources.

## Technology Stack
- **Flutter**: For building the mobile app interface.
- **SQLite**: For local data storage.
- **Firebase Firestore**: For remote storage and sync.
- **Firebase Authentication**: For user authentication.
- **Flutter Local Notifications**: For reminding users to log expenses.

## Setup & Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/expense-tracker-app.git

2. Install dependencies:
   ```bash
   flutter pub get

3. Setup Firebase:

   Follow the Firebase setup instructions for iOS and Android.
   Add your google-services.json (for Android) and GoogleService-Info.plist (for iOS) to the respective platforms.


4. Initialize the local database: The ExpenseDB class initializes the Sqflite database.

5. Run the application:
   ```bash
   flutter run 


## Future Enhancements

### 1. Graphs and Visualizations
- Integrate graphical representations of expense summaries to provide users with a clearer view of their spending habits.
  
### 2. Expense Categories
- Allow users to categorize expenses for better tracking and generate reports based on those categories.

### 3. Multi-Currency Support
- Implement support for tracking expenses in different currencies to cater to a wider audience.


## Contact
Deepak Rai   
LinkedIn: https://www.linkedin.com/in/deepak-rai-993320224/
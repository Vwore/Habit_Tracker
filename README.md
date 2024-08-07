Habit Tracker
Project Overview
Habit Tracker is a Flutter application designed to help users manage and track their habits. The app provides features for habit management, including creating and editing habits, setting reminders, tracking progress, and viewing statistics.

Features
Habit Management: Add, edit, and delete habits.
Progress Tracking: View daily, weekly, and monthly progress.
Statistics: Visualize habit tracking data with charts and graphs.
Setup Instructions
Prerequisites
Flutter SDK (version 3.0 or later)
Dart SDK
An IDE such as Android Studio, VSCode, or IntelliJ IDEA
Installation
Clone the Repository

bash
Copy code
git clone https://github.com/Vwore/Habit_Tracker.git
Navigate to the Project Directory

bash
Copy code
cd Habit_Tracker
Install Dependencies

bash
Copy code
flutter pub get
Run the Application

bash
Copy code
flutter run
Code Structure
lib/: Contains the main source code for the app.

main.dart: Entry point of the application.
screens/: Contains the different screens of the app.
models/: Data models for habits and tracking information.
services/: Contains services for Firebase authentication and database interactions.
assets/: Contains images and other assets used in the app.

pubspec.yaml: Lists the dependencies and configuration for the Flutter project.

Usage Instructions
Add a Habit: Navigate to the habit creation screen and input habit details.
Edit a Habit: Select a habit from the list and modify its details.
Delete a Habit: Press Delete button from edit dialog box.
View Progress: Access the progress screen to see tracking data and statistics.
API Documentation
The app uses Firebase for authentication and database services. Ensure you have set up Firebase and included your configuration file in the project.

Authentication: Handles user sign-in and sign-up.
Database: Stores and retrieves habit data, progress, and statistics.
Widget and Feature Descriptions
Home Screen: Use a Tab view to Display Habit Screen, Calendar View, Progress satistics.
Habit Detail Screen: Shows detailed information about a selected habit.
Progress Screen: Provides a visual representation of habit progress with charts and graphs.
Calendar View: Go to Calender screenn to geting specific insight of habit for any selected day.

Styling and Theming
Color Scheme: The app uses a combination of calming and neutral colors for a relaxing user experience.
Fonts: Custom fonts are used to enhance readability and aesthetics.

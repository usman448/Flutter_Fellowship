📝 Notes App

A lightweight and efficient Notes application built with Flutter, using the Hive database for offline data storage. All notes are saved locally and remain available even after restarting the app.

📸 Screenshots
<table> <tr> <td align="center"><b>Splash Screen</b></td> <td align="center"><b>Home Screen</b></td> </tr> <tr> <td><img src="notes_splash.jpeg" width="200"/></td> <td><img src="notes_home.jpeg" width="200"/></td> </tr> </table>
🚀 Features
Custom splash screen with app icon and loading indicator
Add new notes بسهولة using a simple input field
Delete notes instantly with a trash icon
Local data persistence — notes remain محفوظ after app restart
Clean, minimal, and user-friendly interface
🛠️ Tech Stack
Flutter (Dart) — UI development
Hive — fast and lightweight local NoSQL database
hive_flutter — integration layer for Flutter
⚙️ Setup
1. Clone the repository
git clone https://github.com/usman448/Flutter-Fellowship.git
cd Flutter-Fellowship/notesapp
2. Install dependencies
flutter pub get
3. Run the application
flutter run
📁 Project Structure
lib/
├── main.dart           # App entry point and Hive initialization  
├── splash_screen.dart  # Splash screen with loading animation  
├── home_screen.dart    # Main UI for adding, viewing, and deleting notes  
└── assets/
    └── icon.png        # Application icon  
📦 Dependencies
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0
👨‍💻 Author

Usman — Flutter Developer

📄 License

This project is open-source and available under the MIT License.
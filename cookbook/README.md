CookBook 🍳

A modern Flutter-based recipe application powered by the TheMealDB API, allowing users to explore, save, and create recipes with ease.

🚀 Features
Discover and search a wide range of real recipes from TheMealDB
Filter recipes by categories such as Breakfast, Lunch, Dinner, Dessert, and Snacks
Save favorite recipes using local storage
Toggle between Dark and Light themes
Create and edit your own custom recipes
📱 Screens
Home Screen — displays featured and popular recipes
Recipe Detail — shows ingredients, instructions, and cooking steps
Favorites — list of saved recipes with sorting options
Settings — manage theme, preferences, and app info
Add/Edit Recipe — form to create or update recipes
Browse by Category — explore recipes based on categories
🛠️ Tech Stack
Flutter & Dart — application development
TheMealDB API — recipe data source (free, no API key required)
shared_preferences — local data storage
cached_network_image — optimized image loading
http — API communication
▶️ Running the App
Default Run (using free API)
flutter run
Run with Custom API (for future integration)
flutter run \
  --dart-define=API_BASE_URL=https://your-api.com \
  --dart-define=API_KEY=your_key_here
📦 Build APK
flutter build apk --release
📁 Project Structure
lib/
├── main.dart
├── models/         # Data models (Recipe, Ingredient)
├── screens/        # Application screens
├── widgets/        # Reusable UI components
├── services/       # API handling and local storage
└── utils/          # Constants and helper data
🔐 Security Note

API credentials are injected at build time using --dart-define.
They are not stored directly in the source code, ensuring better security.
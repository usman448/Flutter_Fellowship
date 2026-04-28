
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/preferences_service.dart';
import 'utils/constants.dart';

void main() async {
  // SharedPreferences use karne se pehle ye zaroori hai
  WidgetsFlutterBinding.ensureInitialized();

  // Saved theme load karo
  final savedDarkMode = await PreferencesService.loadTheme();

  runApp(CookBookApp(initialDarkMode: savedDarkMode));
}

class CookBookApp extends StatefulWidget {
  final bool initialDarkMode;
  const CookBookApp({super.key, required this.initialDarkMode});

  @override
  State<CookBookApp> createState() => _CookBookAppState();
}

class _CookBookAppState extends State<CookBookApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.initialDarkMode;
  }

  void toggleTheme(bool value) {
    setState(() => isDarkMode = value);
    PreferencesService.saveTheme(value); // save to storage
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kAccentOrange,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.dark(
          primary: kPrimaryColor,
          secondary: kAccentOrange,
          surface: kCardDark,
        ),
        scaffoldBackgroundColor: kDarkBg,
        cardColor: kCardDark,
        fontFamily: 'Roboto',
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}
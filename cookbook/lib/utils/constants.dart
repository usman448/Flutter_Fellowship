// lib/utils/constants.dart
import 'package:flutter/material.dart';

// ─── Colors ───────────────────────────────────────────────
const kPrimaryColor = Color(0xFF00BFA6);  // Main teal/emerald color
const kAccentOrange = Color(0xFFFF7043);  // Time badge color (deep orange)
const kDarkBg       = Color(0xFF0A0F0D);  // Main dark background (deep green-black)
const kCardDark     = Color(0xFF152118);  // Card background (dark forest)
const kCardDark2    = Color(0xFF0E1A12);  // Slightly darker card

// ─── Categories ───────────────────────────────────────────
const kCategories = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Snack'];

// ─── API Configuration ────────────────────────────────────
// These values come from --dart-define at build/run time
// If not provided, free TheMealDB URL is used as default
const kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://www.themealdb.com/api/json/v1/1',
);

// Reserved for future paid API key (empty by default)
const kApiKey = String.fromEnvironment(
  'API_KEY',
  defaultValue: '',
);
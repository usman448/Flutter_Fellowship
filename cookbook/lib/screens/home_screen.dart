import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/constants.dart';
import '../utils/sample_data.dart';
import '../widgets/chip_filter.dart';
import '../widgets/recipe_card.dart';
import '../widgets/rating_stars.dart';
import '../widgets/badge_widget.dart';
import '../widgets/section_header.dart';
import '../services/preferences_service.dart';
import '../services/meal_api_service.dart';
import 'recipe_detail_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;
  late List<Recipe> _recipes;

  @override
  void initState() {
    super.initState();
    // Show sample data first, then load from API
    _recipes = List.from(sampleRecipes);
    _loadFavorites();
    _fetchRecipesFromApi();
  }

  // Load saved favorite IDs and apply them to recipes
  Future<void> _loadFavorites() async {
    final savedIds = await PreferencesService.loadFavorites();
    setState(() {
      for (final recipe in _recipes) {
        recipe.isFavorite = savedIds.contains(recipe.id);
      }
    });
  }

  // Fetch random recipes from TheMealDB API
  Future<void> _fetchRecipesFromApi() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiRecipes = await MealApiService.getRandomMeals(count: 10);
      final savedIds = await PreferencesService.loadFavorites();

      setState(() {
        // Apply saved favorites to freshly loaded recipes
        _recipes = apiRecipes.map((r) {
          return r.copyWith(isFavorite: savedIds.contains(r.id));
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not load recipes. Showing local data.';
        // Fallback to sample data on error
        _recipes = List.from(sampleRecipes);
      });
    }
  }

  // Filter recipes by selected category and search query
  List<Recipe> get _filteredRecipes {
    return _recipes.where((r) {
      final matchCategory =
          _selectedCategory == 'All' || r.category == _selectedCategory;
      final matchSearch =
          r.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  // Featured recipes are those with rating 4.5 or above
  List<Recipe> get _featuredRecipes =>
      _recipes.where((r) => r.rating >= 4.5).toList();

  // Toggle favorite and save updated list to local storage
  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
    final favoriteIds = _recipes
        .where((r) => r.isFavorite)
        .map((r) => r.id)
        .toList();
    PreferencesService.saveFavorites(favoriteIds);
  }

  // Navigate to recipe detail screen
  void _goToDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          recipe: recipe,
          onFavoriteToggle: () => _toggleFavorite(recipe),
        ),
      ),
    );
  }

  // Pull-to-refresh reloads recipes from API
  Future<void> _onRefresh() async {
    await _fetchRecipesFromApi();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecipes;
    final featured = _featuredRecipes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'CookBook',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FavoritesScreen(
                  recipes: _recipes,
                  onFavoriteToggle: _toggleFavorite,
                  onRecipeTap: _goToDetail,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SettingsScreen(
                  isDarkMode: widget.isDarkMode,
                  onThemeToggle: widget.onThemeToggle,
                ),
              ),
            ),
          ),
        ],
      ),

      // Stack allows loading overlay and error banner on top of content
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            color: kPrimaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Search bar - filters recipes in real time
                  TextFormField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search recipes...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: kCardDark,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category filter chips - horizontal scrollable row
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: kCategories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 8),
                      itemBuilder: (_, i) => ChipFilter(
                        label: kCategories[i],
                        isSelected: _selectedCategory == kCategories[i],
                        onTap: () => setState(
                            () => _selectedCategory = kCategories[i]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Featured section - horizontal carousel of top-rated recipes
                  const SectionHeader(title: 'Featured'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: featured.isEmpty
                        ? const Center(child: Text('No featured recipes'))
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: featured.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (_, i) {
                              final r = featured[i];
                              return GestureDetector(
                                onTap: () => _goToDetail(r),
                                child: Container(
                                  width: 280,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    color: kCardDark,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    children: [
                                      // Recipe image
                                      CachedNetworkImage(
                                        imageUrl: r.imageUrl,
                                        width: 280,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: kCardDark2,
                                          child: const Center(
                                            child:
                                                CircularProgressIndicator(
                                              color: kPrimaryColor,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                        errorWidget:
                                            (context, url, error) =>
                                                Container(
                                          color: kCardDark2,
                                          child: const Icon(
                                              Icons.broken_image,
                                              color: Colors.grey),
                                        ),
                                      ),

                                      // Dark gradient overlay for text readability
                                      Positioned.fill(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.transparent,
                                                Colors.black
                                                    .withOpacity(0.75),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Recipe title, rating and time at bottom
                                      Positioned(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              r.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RatingStars(
                                                    rating: r.rating),
                                                TimeBadge(
                                                    minutes: r.cookTime),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 24),

                  // Popular recipes grid section
                  const SectionHeader(title: 'Popular Recipes'),
                  const SizedBox(height: 12),

                  // Empty state when no recipes match filter/search
                  if (filtered.isEmpty && !_isLoading)
                    Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 60),
                        child: Column(
                          children: [
                            Icon(Icons.search_off,
                                size: 60, color: Colors.grey.shade600),
                            const SizedBox(height: 16),
                            const Text(
                              'No recipes found',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search or category filter',
                              style:
                                  TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    // 2-column recipe grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) => RecipeCard(
                        recipe: filtered[i],
                        onTap: () => _goToDetail(filtered[i]),
                        onFavoriteTap: () =>
                            _toggleFavorite(filtered[i]),
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Full screen loading overlay while fetching from API
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            ),

          // Error banner shown at bottom when API call fails
          if (_errorMessage != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 18),
                      onPressed: () =>
                          setState(() => _errorMessage = null),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
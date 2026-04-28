
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/recipe.dart';
import '../utils/constants.dart';
import '../widgets/rating_stars.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final ValueChanged<Recipe> onFavoriteToggle;
  final ValueChanged<Recipe> onRecipeTap;

  const FavoritesScreen({
    super.key,
    required this.recipes,
    required this.onFavoriteToggle,
    required this.onRecipeTap,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _sortBy = 'Cook time (low → high)';

  final _sortOptions = [
    'Cook time (low → high)',
    'Rating (high → low)',
    'A → Z',
  ];

  List<Recipe> get _sortedFavorites {
    final favs = widget.recipes.where((r) => r.isFavorite).toList();
    switch (_sortBy) {
      case 'Cook time (low → high)':
        favs.sort((a, b) => a.cookTime.compareTo(b.cookTime));
        break;
      case 'Rating (high → low)':
        favs.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'A → Z':
        favs.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
    return favs;
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favs = _sortedFavorites;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Sort Dropdown
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: DropdownButton<String>(
              value: _sortBy,
              underline: const SizedBox(),
              icon: const Icon(Icons.tune, size: 18),
              dropdownColor: kCardDark,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              items: _sortOptions
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _sortBy = v!),
            ),
          ),
        ],
      ),
      body: favs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 60, color: Colors.grey.shade600),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorites yet',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart on any recipe to save it here',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _onRefresh,
              color: kPrimaryColor,
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: favs.length,
                itemBuilder: (_, i) {
                  final r = favs[i];
                  return GestureDetector(
                    onTap: () => widget.onRecipeTap(r),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kCardDark,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: r.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    widget.onFavoriteToggle(r);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.favorite,
                                        color: Colors.white, size: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade800,
                                        borderRadius:
                                            BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.category,
                                              size: 10,
                                              color: Colors.white70),
                                          const SizedBox(width: 3),
                                          Text(
                                            r.category,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingStars(
                                        rating: r.rating, size: 11),
                                    Text(
                                      '${r.cookTime}m',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade400),
                                    ),
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
    );
  }
}
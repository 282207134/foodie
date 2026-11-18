import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/recent_search_tile.dart';
import '../widgets/popular_search_chip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  final List<String> _recentSearches = ['Burger', 'Pizza', 'Sushi', 'Salad', 'Thai Food'];
  final List<String> _popularSearches = ['Burger', 'Pizza', 'Sushi', 'Pasta', 'Salad', 'Tacos', 'Ramen', 'Chicken'];
  final List<String> _categories = ['All', 'Restaurants', 'Cuisines', 'Dishes', 'Offers'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBarWidget(
                onTap: () {},
                hintText: 'Search for food, restaurants...',
              ),
            ),
            // Categories
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return PopularSearchChip(
                    label: category,
                    isSelected: index == 0,
                    onTap: () {},
                  );
                },
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recent Searches
                    if (_recentSearches.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recent Searches', style: AppTextStyles.headline4Semibold),
                          TextButtonWidget(
                            text: 'Clear All',
                            onPressed: () => setState(() => _recentSearches.clear()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _recentSearches.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.lightGrey60),
                        itemBuilder: (context, index) {
                          return RecentSearchTile(
                            query: _recentSearches[index],
                            onTap: () => _performSearch(_recentSearches[index]),
                            onDelete: () => setState(() => _recentSearches.removeAt(index)),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                    // Popular Searches
                    Text('Popular Searches', style: AppTextStyles.headline4Semibold),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _popularSearches.map((search) => PopularSearchChip(
                        label: search,
                        isSelected: false,
                        onTap: () => _performSearch(search),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch(String query) {
    _searchController.text = query;
    context.push('/search-result');
  }
}
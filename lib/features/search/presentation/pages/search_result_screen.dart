import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/food_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/search_bar_widget.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Relevance';
  
  final List<String> _filters = ['All', 'Restaurants', 'Dishes', 'Cuisines'];
  final List<String> _sortOptions = ['Relevance', 'Rating', 'Delivery Time', 'Price: Low to High', 'Price: High to Low'];
  
  final List<FoodItem> _searchResults = [
    FoodItem(
      id: '1',
      name: 'Chicken Burger',
      description: 'Grilled chicken breast with fresh lettuce, tomato, and special sauce',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      price: 12.99,
      rating: 4.5,
      reviewCount: 234,
      category: 'Burgers',
      tags: ['Popular', 'Spicy'],
      isPopular: true,
      preparationTime: 25,
    ),
    FoodItem(
      id: '2',
      name: 'Margherita Pizza',
      description: 'Classic Italian pizza with fresh mozzarella, tomato sauce, and basil',
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
      price: 15.99,
      rating: 4.8,
      reviewCount: 567,
      category: 'Pizza',
      tags: ['Vegetarian', 'Cheesy'],
      isPopular: true,
      preparationTime: 30,
    ),
    FoodItem(
      id: '3',
      name: 'Sushi Platter',
      description: 'Fresh assorted sushi with salmon, tuna, and shrimp',
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
      price: 24.99,
      rating: 4.7,
      reviewCount: 189,
      category: 'Japanese',
      tags: ['Fresh', 'Premium'],
      preparationTime: 35,
    ),
    FoodItem(
      id: '4',
      name: 'Pad Thai',
      description: 'Stir-fried rice noodles with shrimp, tofu, peanuts, and bean sprouts',
      imageUrl: 'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=400',
      price: 13.99,
      rating: 4.4,
      reviewCount: 312,
      category: 'Thai',
      tags: ['Spicy', 'Noodles'],
      preparationTime: 20,
    ),
    FoodItem(
      id: '5',
      name: 'Caesar Salad',
      description: 'Crisp romaine lettuce with parmesan, croutons, and caesar dressing',
      imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
      price: 10.99,
      rating: 4.2,
      reviewCount: 156,
      category: 'Salad',
      tags: ['Healthy', 'Light'],
      preparationTime: 15,
    ),
    FoodItem(
      id: '6',
      name: 'Beef Tacos',
      description: 'Soft corn tortillas with seasoned beef, fresh salsa, and guacamole',
      imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400',
      price: 11.99,
      rating: 4.6,
      reviewCount: 278,
      category: 'Mexican',
      tags: ['Spicy', 'Street Food'],
      preparationTime: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: AppColors.background,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: AppColors.onSurface),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SearchBarWidget(
                        onTap: () => context.pop(),
                        hintText: 'Search for food, restaurants...',
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _showFilterBottomSheet(),
                      icon: const Icon(Icons.tune_rounded, size: 26, color: AppColors.onSurface),
                    ),
                  ],
                ),
              ),
            ),
            // Filter Chips
            SliverToBoxAdapter(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    return CategoryChip(
                      label: filter,
                      isSelected: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    );
                  },
                ),
              ),
            ),
            // Results Count
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_searchResults.length} results found',
                      style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
                    ),
                    _buildSortDropdown(),
                  ],
                ),
              ),
            ),
            // Results Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final food = _searchResults[index];
                    return FoodCard(
                      food: food,
                      onTap: () => context.push('/food-detail/${food.id}'),
                    );
                  },
                  childCount: _searchResults.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey60),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSort,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.black60),
          style: AppTextStyles.placeholder1Medium.copyWith(color: AppColors.onSurface),
          items: _sortOptions.map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          )).toList(),
          onChanged: (value) => setState(() => _selectedSort = value!),
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterBottomSheet(
        selectedFilter: _selectedFilter,
        onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
      ),
    );
  }
}

class _FilterBottomSheet extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterBottomSheet({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGrey60,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Filters', style: AppTextStyles.headline3Bold),
          const SizedBox(height: 24),
          Text('Category', style: AppTextStyles.headline4Semibold),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Restaurants', 'Dishes', 'Cuisines'].map((filter) => FilterChip(
              label: Text(filter),
              selected: selectedFilter == filter,
              onSelected: (selected) => onFilterChanged(filter),
              selectedColor: AppColors.primary.withValues(alpha: 0.2),
              checkmarkColor: AppColors.primary,
              labelStyle: AppTextStyles.headline5Medium,
              side: BorderSide(color: selectedFilter == filter ? AppColors.primary : AppColors.lightGrey60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            )).toList(),
          ),
          const SizedBox(height: 24),
          // More filters here...
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Apply Filters',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
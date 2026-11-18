import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/food_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';
  
  final List<String> _categories = ['All', 'Near You', 'Trending', 'Healthy Food'];
  
  final List<FoodItem> _recommendedFoods = [
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
  ];

  final List<FoodItem> _nearYouFoods = [
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
  ];

  final List<FoodItem> _healthyFoods = [
    FoodItem(
      id: '6',
      name: 'Quinoa Bowl',
      description: 'Protein-packed quinoa with roasted vegetables and tahini dressing',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      price: 14.99,
      rating: 4.6,
      reviewCount: 98,
      category: 'Healthy',
      tags: ['Vegan', 'Protein'],
      preparationTime: 20,
    ),
    FoodItem(
      id: '7',
      name: 'Acai Bowl',
      description: 'Organic acai berries with granola, fresh fruits, and honey',
      imageUrl: 'https://images.unsplash.com/photo-1590301157890-48150938902f?w=400',
      price: 11.99,
      rating: 4.7,
      reviewCount: 203,
      category: 'Healthy',
      tags: ['Vegan', 'Antioxidants'],
      preparationTime: 10,
    ),
    FoodItem(
      id: '8',
      name: 'Grilled Salmon',
      description: 'Wild-caught salmon with steamed asparagus and lemon butter sauce',
      imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
      price: 22.99,
      rating: 4.8,
      reviewCount: 145,
      category: 'Healthy',
      tags: ['Keto', 'Omega-3'],
      preparationTime: 25,
    ),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<FoodItem> _getFoodsForCategory(String category) {
    switch (category) {
      case 'Near You':
        return _nearYouFoods;
      case 'Trending':
        return _recommendedFoods;
      case 'Healthy Food':
        return _healthyFoods;
      default:
        return [..._recommendedFoods, ..._nearYouFoods.take(2)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFoods = _getFoodsForCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
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
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.restaurant_rounded, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Deliver to',
                            style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                          ),
                          Row(
                            children: [
                              Text(
                                'Current Location',
                                style: AppTextStyles.headline5Semibold.copyWith(fontSize: 14),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.black60),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.push('/chat'),
                      icon: const Icon(Icons.chat_bubble_outline_rounded, size: 26, color: AppColors.onSurface),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => context.push('/side-menu'),
                      icon: const Icon(Icons.menu_rounded, size: 26, color: AppColors.onSurface),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SearchBarWidget(onTap: () => context.push('/search')),
                ),
              ),
            ),
            // Categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 56,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return CategoryChip(
                      label: category,
                      isSelected: _selectedCategory == category,
                      onTap: () => setState(() => _selectedCategory = category),
                    );
                  },
                ),
              ),
            ),
            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory == 'All' ? 'Recommended' : _selectedCategory,
                      style: AppTextStyles.headline4Semibold,
                    ),
                    if (_selectedCategory != 'All')
                      TextButtonWidget(
                        text: 'See All',
                        onPressed: () => context.push('/search-result'),
                      ),
                  ],
                ),
              ),
            ),
            // Food Cards Grid
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
                    final food = currentFoods[index];
                    return FoodCard(
                      food: food,
                      onTap: () => context.push('/food-detail/${food.id}'),
                    );
                  },
                  childCount: currentFoods.length,
                ),
              ),
            ),
            // Horizontal Food Cards (Near You / Trending sections)
            if (_selectedCategory == 'All') ...[
              _buildHorizontalSection(
                title: 'Near You',
                foods: _nearYouFoods,
                onSeeAll: () => setState(() => _selectedCategory = 'Near You'),
              ),
              _buildHorizontalSection(
                title: 'Trending',
                foods: _recommendedFoods,
                onSeeAll: () => setState(() => _selectedCategory = 'Trending'),
              ),
              _buildHorizontalSection(
                title: 'Healthy Food',
                foods: _healthyFoods,
                onSeeAll: () => setState(() => _selectedCategory = 'Healthy Food'),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 100)), // Bottom nav space
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHorizontalSection({
    required String title,
    required List<FoodItem> foods,
    required VoidCallback onSeeAll,
  }) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.headline4Semibold),
                TextButtonWidget(text: 'See All', onPressed: onSeeAll),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  child: FoodCard(
                    food: food,
                    isHorizontal: true,
                    onTap: () => context.push('/food-detail/${food.id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.black10,
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', isActive: true, onTap: () {}),
              _NavItem(icon: Icons.search_rounded, label: 'Search', isActive: false, onTap: () => context.push('/search')),
              _NavItem(icon: Icons.shopping_cart_rounded, label: 'Cart', isActive: false, onTap: () => context.push('/cart')),
              _NavItem(icon: Icons.person_rounded, label: 'Profile', isActive: false, onTap: () => context.push('/profile')),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? AppColors.primary : AppColors.black60,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.placeholder1Regular.copyWith(
                color: isActive ? AppColors.primary : AppColors.black60,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
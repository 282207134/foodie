import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';

class FoodDetailScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailScreen({super.key, required this.foodId});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;
  String _selectedSize = 'Regular';
  final List<String> _sizes = ['Small', 'Regular', 'Large'];
  
  final Map<String, FoodItem> _foodItems = {
    '1': FoodItem(
      id: '1',
      name: 'Chicken Burger',
      description: 'Grilled chicken breast with fresh lettuce, tomato, and special sauce. Served with crispy fries and a soft drink.',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      price: 12.99,
      rating: 4.5,
      reviewCount: 234,
      category: 'Burgers',
      tags: ['Popular', 'Spicy'],
      isPopular: true,
      preparationTime: 25,
    ),
    '2': FoodItem(
      id: '2',
      name: 'Margherita Pizza',
      description: 'Classic Italian pizza with fresh mozzarella, tomato sauce, and basil. Made with authentic Italian ingredients.',
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
      price: 15.99,
      rating: 4.8,
      reviewCount: 567,
      category: 'Pizza',
      tags: ['Vegetarian', 'Cheesy'],
      isPopular: true,
      preparationTime: 30,
    ),
    '3': FoodItem(
      id: '3',
      name: 'Sushi Platter',
      description: 'Fresh assorted sushi with salmon, tuna, shrimp, and crab. Served with soy sauce, wasabi, and pickled ginger.',
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=400',
      price: 24.99,
      rating: 4.7,
      reviewCount: 189,
      category: 'Japanese',
      tags: ['Fresh', 'Premium'],
      preparationTime: 35,
    ),
  };

  FoodItem get _food => _foodItems[widget.foodId] ?? _foodItems['1']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black10,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onSurface, size: 20),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black10,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_rounded, color: AppColors.onSurface, size: 22),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: _food.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.lightGrey20,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.lightGrey20,
                      child: const Icon(Icons.restaurant_rounded, size: 80, color: AppColors.black40),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.black100.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _food.category,
                                style: AppTextStyles.placeholder1Medium.copyWith(color: AppColors.onPrimary),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, size: 16, color: AppColors.orange100),
                                const SizedBox(width: 4),
                                Text(
                                  _food.rating.toString(),
                                  style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.onPrimary),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${_food.reviewCount} reviews)',
                                  style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.9)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _food.name,
                          style: AppTextStyles.headline1Bold.copyWith(color: AppColors.onPrimary, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text('Description', style: AppTextStyles.headline4Semibold),
                  const SizedBox(height: 12),
                  Text(
                    _food.description,
                    style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _food.tags.map((tag) => _buildTag(tag)).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Size Selection
                  Text('Size', style: AppTextStyles.headline4Semibold),
                  const SizedBox(height: 12),
                  Row(
                    children: _sizes.map((size) => _buildSizeChip(size)).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity', style: AppTextStyles.headline4Semibold),
                      _buildQuantitySelector(),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Add to Cart Button
                  PrimaryButton(
                    text: 'Add to Cart - \$${(_food.price * _quantity).toStringAsFixed(2)}',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${_quantity}x ${_food.name} to cart'),
                          backgroundColor: AppColors.success100,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                      context.pop();
                    },
                    leadingIcon: Icons.shopping_cart_rounded,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: AppTextStyles.placeholder1Medium.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildSizeChip(String size) {
    final isSelected = _selectedSize == size;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedSize = size),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.lightGrey60,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              size,
              style: AppTextStyles.headline5Medium.copyWith(
                color: isSelected ? AppColors.onPrimary : AppColors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey60),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
            icon: const Icon(Icons.remove_rounded, size: 20),
            color: _quantity > 1 ? AppColors.onSurface : AppColors.black40,
          ),
          SizedBox(
            width: 48,
            child: Center(
              child: Text(
                '$_quantity',
                style: AppTextStyles.headline4Semibold,
              ),
            ),
          ),
          IconButton(
            onPressed: _quantity < 99 ? () => setState(() => _quantity++) : null,
            icon: const Icon(Icons.add_rounded, size: 20),
            color: _quantity < 99 ? AppColors.onSurface : AppColors.black40,
          ),
        ],
      ),
    );
  }
}
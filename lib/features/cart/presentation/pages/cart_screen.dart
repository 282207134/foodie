import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(
      foodItem: FoodItem(
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
      quantity: 2,
    ),
    CartItem(
      foodItem: FoodItem(
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
      quantity: 1,
    ),
  ];

  double get _subtotal => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get _deliveryFee => _subtotal > 30 ? 0 : 3.99;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _deliveryFee + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      ),
      bottomNavigationBar: _cartItems.isEmpty ? null : _buildBottomBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(Icons.shopping_cart_outlined, size: 60, color: AppColors.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: AppTextStyles.headline2Bold,
            ),
            const SizedBox(height: 8),
            Text(
              'Add some delicious food to get started!',
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Explore Restaurants',
              onPressed: () => context.go('/home'),
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return CustomScrollView(
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
            child: Text('Cart', style: AppTextStyles.headline3Bold),
          ),
        ),
        // Restaurant Section
        SliverToBoxAdapter(
          child: Column(
            children: _cartItems.map((item) => _buildCartItem(item)).toList(),
          ),
        ),
        // Price Summary
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black10,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildPriceRow('Subtotal', _subtotal),
                const SizedBox(height: 12),
                _buildPriceRow('Delivery Fee', _deliveryFee, isFree: _deliveryFee == 0),
                const SizedBox(height: 12),
                _buildPriceRow('Tax (8%)', _tax),
                const Divider(height: 24, color: AppColors.lightGrey60),
                _buildPriceRow('Total', _total, isTotal: true),
                if (_deliveryFee > 0) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Add \$${(30 - _subtotal).toStringAsFixed(2)} more for free delivery!',
                    style: AppTextStyles.placeholder1Medium.copyWith(color: AppColors.primary),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black10,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.foodItem.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: AppColors.lightGrey20,
                child: const Icon(Icons.restaurant_rounded, size: 32, color: AppColors.black40),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodItem.name,
                  style: AppTextStyles.headline5Semibold,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.foodItem.price.toStringAsFixed(2)}',
                  style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                _buildQuantitySelector(item),
              ],
            ),
          ),
          // Delete
          InkWell(
            onTap: () => setState(() => _cartItems.remove(item)),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.delete_outline_rounded, size: 22, color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(CartItem item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: item.quantity > 1 ? () => setState(() => item.quantity--) : null,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
            child: Container(
              width: 32,
              height: 32,
              child: Center(
                child: Icon(Icons.remove_rounded, size: 18, color: item.quantity > 1 ? AppColors.onSurface : AppColors.black40),
              ),
            ),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '${item.quantity}',
              style: AppTextStyles.headline5Semibold,
            ),
          ),
          InkWell(
            onTap: item.quantity < 99 ? () => setState(() => item.quantity++) : null,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
            child: Container(
              width: 32,
              height: 32,
              child: Center(
                child: Icon(Icons.add_rounded, size: 18, color: item.quantity < 99 ? AppColors.onSurface : AppColors.black40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isFree = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.headline4Bold
              : AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
        ),
        Text(
          isFree ? 'FREE' : '\$${value.toStringAsFixed(2)}',
          style: isTotal
              ? AppTextStyles.headline4Bold.copyWith(color: AppColors.primary)
              : isFree
                  ? AppTextStyles.bodytext1Medium.copyWith(color: AppColors.success100)
                  : AppTextStyles.bodytext1Medium,
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        child: PrimaryButton(
          text: 'Checkout - \$${_total.toStringAsFixed(2)}',
          onPressed: () {
            // Navigate to checkout
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Proceeding to checkout...'),
                backgroundColor: AppColors.success100,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
          leadingIcon: Icons.payment_rounded,
        ),
      ),
    );
  }
}

class CartItem {
  final FoodItem foodItem;
  int quantity;

  CartItem({required this.foodItem, this.quantity = 1});

  double get totalPrice => foodItem.price * quantity;
}
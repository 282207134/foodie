import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<String> _tabs = ['Today', 'This Month', 'Past Orders'];
  
  final List<Order> _todayOrders = [
    Order(
      id: 'ORD-20240115-001',
      items: [
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
      ],
      subtotal: 25.98,
      deliveryFee: 0,
      tax: 2.08,
      total: 28.06,
      status: 'Delivered',
      orderDate: DateTime.now().subtract(const Duration(hours: 2)),
      deliveryAddress: '123 Main St, Apt 4B',
      paymentMethod: 'Visa •••• 4242',
    ),
  ];

  final List<Order> _thisMonthOrders = [
    Order(
      id: 'ORD-20240110-002',
      items: [
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
        CartItem(
          foodItem: FoodItem(
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
          quantity: 1,
        ),
      ],
      subtotal: 40.98,
      deliveryFee: 3.99,
      tax: 3.28,
      total: 48.25,
      status: 'Delivered',
      orderDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryAddress: '123 Main St, Apt 4B',
      paymentMethod: 'Apple Pay',
    ),
  ];

  final List<Order> _pastOrders = [
    Order(
      id: 'ORD-20231220-003',
      items: [
        CartItem(
          foodItem: FoodItem(
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
          quantity: 2,
        ),
      ],
      subtotal: 27.98,
      deliveryFee: 0,
      tax: 2.24,
      total: 30.22,
      status: 'Delivered',
      orderDate: DateTime.now().subtract(const Duration(days: 25)),
      deliveryAddress: '456 Oak Ave',
      paymentMethod: 'Visa •••• 4242',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: AppColors.onSurface),
                  ),
                  const SizedBox(width: 8),
                  Text('Order History', style: AppTextStyles.headline3Bold),
                ],
              ),
            ),
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.lightGrey10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: AppColors.onPrimary,
                unselectedLabelColor: AppColors.black60,
                labelStyle: AppTextStyles.headline5Semibold,
                unselectedLabelStyle: AppTextStyles.headline5Medium,
                dividerColor: Colors.transparent,
                tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList(_todayOrders),
                  _buildOrderList(_thisMonthOrders),
                  _buildOrderList(_pastOrders),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return _buildEmptyState();
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(orders[index]);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightGrey10,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.receipt_long_rounded, size: 50, color: AppColors.black40),
            ),
            const SizedBox(height: 24),
            Text(
              'No orders yet',
              style: AppTextStyles.headline3Bold,
            ),
            const SizedBox(height: 8),
            Text(
              'Your orders will appear here',
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Start Ordering',
              onPressed: () => context.go('/home'),
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    Color statusColor;
    IconData statusIcon;
    switch (order.status) {
      case 'Delivered':
        statusColor = AppColors.success100;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Preparing':
        statusColor = AppColors.primary;
        statusIcon = Icons.restaurant_rounded;
        break;
      case 'On the way':
        statusColor = AppColors.orange100;
        statusIcon = Icons.delivery_dining_rounded;
        break;
      default:
        statusColor = AppColors.primary;
        statusIcon = Icons.info_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${order.id}',
                style: AppTextStyles.headline5Medium.copyWith(color: AppColors.black60),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      order.status,
                      style: AppTextStyles.placeholder1Medium.copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Order Date
          Text(
            _formatDate(order.orderDate),
            style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
          ),
          const SizedBox(height: 12),
          // Items
          ...order.items.take(2).map((item) => _buildOrderItem(item)).toList(),
          if (order.items.length > 2)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '+${order.items.length - 2} more items',
                style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
              ),
            ),
          const SizedBox(height: 12),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: AppTextStyles.headline4Bold.copyWith(color: AppColors.primary),
              ),
              Row(
                children: [
                  TextButtonWidget(
                    text: 'Reorder',
                    onPressed: () {},
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  TextButtonWidget(
                    text: 'Track',
                    onPressed: () => context.push('/tracking/${order.id}'),
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.foodItem.imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 48,
                height: 48,
                color: AppColors.lightGrey20,
                child: const Icon(Icons.restaurant_rounded, size: 20, color: AppColors.black40),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodItem.name,
                  style: AppTextStyles.bodytext1Regular,
                ),
                Text(
                  'Qty: ${item.quantity} × \$${item.foodItem.price.toStringAsFixed(2)}',
                  style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String status;
  final DateTime orderDate;
  final String deliveryAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.orderDate,
    required this.deliveryAddress,
    required this.paymentMethod,
  });
}

class CartItem {
  final FoodItem foodItem;
  final int quantity;

  CartItem({required this.foodItem, this.quantity = 1});

  double get totalPrice => foodItem.price * quantity;
}
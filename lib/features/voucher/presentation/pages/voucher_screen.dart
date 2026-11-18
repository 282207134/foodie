import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../widgets/voucher_card.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Voucher> _availableVouchers = [
    Voucher(
      id: '1',
      title: 'Welcome Discount',
      description: 'Get 20% off on your first order',
      code: 'WELCOME20',
      discountValue: 20,
      discountType: 'percentage',
      minOrderValue: 15.00,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400',
    ),
    Voucher(
      id: '2',
      title: 'Free Delivery',
      description: 'Free delivery on orders over \$25',
      code: 'FREEDEL',
      discountValue: 0,
      discountType: 'free_delivery',
      minOrderValue: 25.00,
      expiryDate: DateTime.now().add(const Duration(days: 15)),
      imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400',
    ),
    Voucher(
      id: '3',
      title: 'Weekend Special',
      description: '\$5 off on orders over \$30',
      code: 'WEEKEND5',
      discountValue: 5,
      discountType: 'fixed',
      minOrderValue: 30.00,
      expiryDate: DateTime.now().add(const Duration(days: 7)),
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
    ),
  ];

  final List<Voucher> _usedVouchers = [
    Voucher(
      id: '4',
      title: 'New Year Sale',
      description: '30% off on all orders',
      code: 'NEWYEAR30',
      discountValue: 30,
      discountType: 'percentage',
      minOrderValue: 20.00,
      expiryDate: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400',
      isUsed: true,
    ),
    Voucher(
      id: '5',
      title: 'Birthday Treat',
      description: 'Free dessert with any order',
      code: 'BIRTHDAY',
      discountValue: 0,
      discountType: 'free_item',
      minOrderValue: 0,
      expiryDate: DateTime.now().subtract(const Duration(days: 10)),
      imageUrl: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400',
      isUsed: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        title: Text('My Vouchers', style: AppTextStyles.headline3Bold),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.black60,
          labelStyle: AppTextStyles.headline5Semibold,
          unselectedLabelStyle: AppTextStyles.headline5Medium,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'Used'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVoucherList(_availableVouchers, false),
          _buildVoucherList(_usedVouchers, true),
        ],
      ),
    );
  }

  Widget _buildVoucherList(List<Voucher> vouchers, bool isUsed) {
    if (vouchers.isEmpty) {
      return _buildEmptyState(isUsed);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        return VoucherCard(
          voucher: vouchers[index],
          isUsed: isUsed,
          onTap: () => context.push('/voucher-detail/${vouchers[index].id}'),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isUsed) {
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
              child: Icon(
                isUsed ? Icons.check_circle_outline_rounded : Icons.local_offer_outlined,
                size: 50,
                color: AppColors.black40,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isUsed ? 'No used vouchers' : 'No available vouchers',
              style: AppTextStyles.headline3Bold,
            ),
            const SizedBox(height: 8),
            Text(
              isUsed
                  ? 'Your used vouchers will appear here'
                  : 'Check back later for new offers!',
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
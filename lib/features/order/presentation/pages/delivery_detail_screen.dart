import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final String orderId;

  const DeliveryDetailScreen({super.key, required this.orderId});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
        ),
        title: Text('Order Details', style: AppTextStyles.headline4Semibold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryVariant],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.onPrimary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'ON THE WAY',
                            style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.onPrimary),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Order #ORD-20240115-001',
                          style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem('Restaurant', 'Burger King'),
                        ),
                        Expanded(
                          child: _buildDetailItem('Delivery Time', '1:25 PM'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem('Distance', '2.3 km'),
                        ),
                        Expanded(
                          child: _buildDetailItem('Driver', 'Mike Johnson'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Driver Info
              Text('Driver Details', style: AppTextStyles.headline4Semibold),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGrey60),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.person_rounded, size: 30, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mike Johnson', style: AppTextStyles.headline5Semibold),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star_rounded, size: 16, color: AppColors.orange100),
                              const SizedBox(width: 4),
                              Text('4.9 (234 ratings)', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _buildDriverAction(Icons.chat_bubble_outline_rounded, () {}),
                        _buildDriverAction(Icons.call_rounded, () {}),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Vehicle Info
              Text('Vehicle Details', style: AppTextStyles.headline4Semibold),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGrey60),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.two_wheeler_rounded, size: 28, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Motorcycle', style: AppTextStyles.headline5Semibold),
                          const SizedBox(height: 4),
                          Text('Yamaha NMAX 155', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                          const SizedBox(height: 2),
                          Text('Plate: ABC 1234', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Delivery Address
              Text('Delivery Address', style: AppTextStyles.headline4Semibold),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGrey60),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home', style: AppTextStyles.headline5Semibold),
                              Text('123 Main St, Apt 4B, Downtown', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Instructions:', style: AppTextStyles.bodytext1Medium),
                    const SizedBox(height: 4),
                    Text('Leave at door, ring doorbell', style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Order Items
              Text('Order Items', style: AppTextStyles.headline4Semibold),
              const SizedBox(height: 12),
              _buildOrderItem('Chicken Burger', 2, 12.99),
              _buildOrderItem('French Fries', 1, 4.99),
              _buildOrderItem('Coca Cola', 2, 2.50),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGrey60),
                ),
                child: Column(
                  children: [
                    _buildPriceRow('Subtotal', 35.97),
                    _buildPriceRow('Delivery Fee', 3.99),
                    _buildPriceRow('Tax (8%)', 2.88),
                    const Divider(height: 16),
                    _buildPriceRow('Total', 42.84, isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Timeline
              Text('Order Timeline', style: AppTextStyles.headline4Semibold),
              const SizedBox(height: 12),
              _buildTimelineItem('Order Placed', 'Jan 15, 2024 • 12:30 PM', true),
              _buildTimelineItem('Restaurant Confirmed', 'Jan 15, 2024 • 12:32 PM', true),
              _buildTimelineItem('Preparing Food', 'Jan 15, 2024 • 12:35 PM', true),
              _buildTimelineItem('Ready for Pickup', 'Jan 15, 2024 • 1:00 PM', true),
              _buildTimelineItem('Driver Picked Up', 'Jan 15, 2024 • 1:05 PM', true),
              _buildTimelineItem('On the Way', 'Jan 15, 2024 • 1:10 PM', false, isActive: true),
              _buildTimelineItem('Arriving Soon', 'Estimated 1:20 PM', false),
              _buildTimelineItem('Delivered', 'Estimated 1:25 PM', false, isLast: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.8))),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.onPrimary)),
      ],
    );
  }

  Widget _buildDriverAction(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.onPrimary, size: 20),
      ),
    );
  }

  Widget _buildOrderItem(String name, int quantity, double price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey60),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 56,
              height: 56,
              color: AppColors.lightGrey10,
              child: const Icon(Icons.restaurant_rounded, size: 24, color: AppColors.black40),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.bodytext1Regular),
                Text('Qty: $quantity', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
              ],
            ),
          ),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTextStyles.headline4Bold
                : AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: isTotal
                ? AppTextStyles.headline4Bold.copyWith(color: AppColors.primary)
                : AppTextStyles.bodytext1Medium,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool isCompleted, {bool isActive = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success100 : (isActive ? AppColors.primary : AppColors.surface),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isCompleted ? AppColors.success100 : (isActive ? AppColors.primary : AppColors.lightGrey60),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check_rounded, size: 12, color: AppColors.onPrimary)
                  : null,
            ),
            if (!isLast)
              Expanded(
                child: Container(
                  width: 2,
                  color: isCompleted ? AppColors.success100 : AppColors.lightGrey60,
                  margin: const EdgeInsets.only(left: 9),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodytext1Regular.copyWith(
                    color: isCompleted ? AppColors.onSurface : (isActive ? AppColors.primary : AppColors.black60),
                    fontWeight: isCompleted || isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(time, style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
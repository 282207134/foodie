import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';
import '../../../../shared/widgets/primary_button.dart';

class VoucherDetailScreen extends StatefulWidget {
  final String voucherId;

  const VoucherDetailScreen({super.key, required this.voucherId});

  @override
  State<VoucherDetailScreen> createState() => _VoucherDetailScreenState();
}

class _VoucherDetailScreenState extends State<VoucherDetailScreen> {
  final Map<String, Voucher> _vouchers = {
    '1': Voucher(
      id: '1',
      title: 'Welcome Discount',
      description: 'Get 20% off on your first order at any restaurant. Valid for new users only.',
      code: 'WELCOME20',
      discountValue: 20,
      discountType: 'percentage',
      minOrderValue: 15.00,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      imageUrl: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400',
    ),
  };

  Voucher get _voucher => _vouchers[widget.voucherId] ?? _vouchers['1']!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: AppColors.black10, blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onSurface, size: 20),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: _voucher.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.lightGrey20),
                    errorWidget: (context, url, error) => Container(color: AppColors.lightGrey20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.primary.withValues(alpha: 0.9)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.onPrimary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getVoucherTypeLabel(),
                            style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.onPrimary),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _voucher.title,
                          style: AppTextStyles.headline1Bold.copyWith(color: AppColors.onPrimary, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Code section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Text('Voucher Code', style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _voucher.code,
                              style: AppTextStyles.headline1Bold.copyWith(
                                color: AppColors.primary,
                                fontSize: 32,
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Code copied to clipboard!'),
                                    backgroundColor: AppColors.success100,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy_rounded, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Description
                  Text('Description', style: AppTextStyles.headline4Semibold),
                  const SizedBox(height: 12),
                  Text(
                    _voucher.description,
                    style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  // Terms
                  Text('Terms & Conditions', style: AppTextStyles.headline4Semibold),
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
                        _buildTermRow('Minimum order', '\$${_voucher.minOrderValue.toStringAsFixed(2)}'),
                        _buildTermRow('Valid until', _formatDate(_voucher.expiryDate)),
                        _buildTermRow('Discount type', _getVoucherTypeLabel()),
                        if (_voucher.discountType == 'percentage')
                          _buildTermRow('Maximum discount', '\$${(_voucher.minOrderValue * _voucher.discountValue / 100).toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [BoxShadow(color: AppColors.black10, blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: PrimaryButton(
            text: 'Use Now',
            onPressed: () {
              context.go('/home');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Voucher ${_voucher.code} applied!'),
                  backgroundColor: AppColors.success100,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            leadingIcon: Icons.shopping_cart_rounded,
          ),
        ),
      ),
    );
  }

  Widget _buildTermRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60)),
          Text(value, style: AppTextStyles.bodytext1Medium),
        ],
      ),
    );
  }

  String _getVoucherTypeLabel() {
    switch (_voucher.discountType) {
      case 'percentage':
        return '${_voucher.discountValue.toInt()}% OFF';
      case 'fixed':
        return '\$${_voucher.discountValue.toStringAsFixed(0)} OFF';
      case 'free_delivery':
        return 'FREE DELIVERY';
      case 'free_item':
        return 'FREE ITEM';
      default:
        return 'VOUCHER';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
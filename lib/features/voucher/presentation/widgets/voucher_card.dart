import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final bool isUsed;
  final VoidCallback onTap;

  const VoucherCard({
    super.key,
    required this.voucher,
    required this.isUsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isUsed ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isUsed ? AppColors.lightGrey10 : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUsed ? AppColors.lightGrey60 : AppColors.primary.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: isUsed
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Opacity(
                  opacity: isUsed ? 0.3 : 1.0,
                  child: CachedNetworkImage(
                    imageUrl: voucher.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.lightGrey10),
                    errorWidget: (context, url, error) => Container(color: AppColors.lightGrey10),
                  ),
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isUsed
                        ? [AppColors.black100.withValues(alpha: 0.7), AppColors.black100.withValues(alpha: 0.9)]
                        : [AppColors.primary.withValues(alpha: 0.8), AppColors.primary.withValues(alpha: 0.6)],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Left side - Voucher info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isUsed ? AppColors.black60 : AppColors.onPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isUsed ? 'USED' : _getVoucherTypeLabel(),
                            style: AppTextStyles.placeholder2Regular.copyWith(
                              color: isUsed ? AppColors.onSurface : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Title
                        Text(
                          voucher.title,
                          style: AppTextStyles.headline3Bold.copyWith(color: AppColors.onPrimary),
                        ),
                        const SizedBox(height: 4),
                        // Description
                        Text(
                          voucher.description,
                          style: AppTextStyles.bodytext1Regular.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Code & Expiry
                        Row(
                          children: [
                            if (!isUsed) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.onPrimary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  voucher.code,
                                  style: AppTextStyles.headline5Semibold.copyWith(
                                    color: AppColors.onPrimary,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                            // Expiry
                            Row(
                              children: [
                                Icon(
                                  isUsed ? Icons.event_busy_rounded : Icons.event_rounded,
                                  size: 14,
                                  color: AppColors.onPrimary.withValues(alpha: 0.8),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _formatDate(voucher.expiryDate),
                                  style: AppTextStyles.placeholder1Regular.copyWith(
                                    color: AppColors.onPrimary.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right side - Discount value
                  if (!isUsed)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _getDiscountText(),
                          style: AppTextStyles.headline1Bold.copyWith(
                            color: AppColors.onPrimary,
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Min. order \$${voucher.minOrderValue.toStringAsFixed(2)}',
                          style: AppTextStyles.placeholder1Regular.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    )
                  else
                    Icon(
                      Icons.check_circle_rounded,
                      size: 48,
                      color: AppColors.success100,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getVoucherTypeLabel() {
    switch (voucher.discountType) {
      case 'percentage':
        return '${voucher.discountValue.toInt()}% OFF';
      case 'fixed':
        return '\$${voucher.discountValue.toStringAsFixed(0)} OFF';
      case 'free_delivery':
        return 'FREE DELIVERY';
      case 'free_item':
        return 'FREE ITEM';
      default:
        return 'VOUCHER';
    }
  }

  String _getDiscountText() {
    switch (voucher.discountType) {
      case 'percentage':
        return '${voucher.discountValue.toInt()}%';
      case 'fixed':
        return '\$${voucher.discountValue.toStringAsFixed(0)}';
      case 'free_delivery':
        return 'FREE';
      case 'free_item':
        return 'FREE';
      default:
        return '';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final bool isHorizontal;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: isHorizontal ? _buildHorizontalLayout() : _buildVerticalLayout(),
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: food.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 160,
                  color: AppColors.lightGrey20,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 160,
                  color: AppColors.lightGrey20,
                  child: const Icon(Icons.restaurant_rounded, size: 48, color: AppColors.black40),
                ),
              ),
            ),
            // Popular badge
            if (food.isPopular)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Popular',
                    style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.onPrimary),
                  ),
                ),
              ),
            // Favorite button
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black10,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.favorite_border_rounded, size: 18, color: AppColors.onSurface),
              ),
            ),
          ],
        ),
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: AppTextStyles.headline5Semibold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  food.description,
                  style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Rating & time
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: AppColors.orange100),
                    const SizedBox(width: 4),
                    Text(
                      food.rating.toString(),
                      style: AppTextStyles.placeholder1Medium,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${food.reviewCount})',
                      style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.black60),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time_rounded, size: 14, color: AppColors.black60),
                    const SizedBox(width: 4),
                    Text(
                      '${food.preparationTime} min',
                      style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Price & Add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${food.price.toStringAsFixed(2)}',
                      style: AppTextStyles.headline4Bold.copyWith(color: AppColors.primary),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add_rounded, size: 20, color: AppColors.onPrimary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      children: [
        // Image
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: food.imageUrl,
                width: 100,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100,
                  color: AppColors.lightGrey20,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 100,
                  color: AppColors.lightGrey20,
                  child: const Icon(Icons.restaurant_rounded, size: 32, color: AppColors.black40),
                ),
              ),
            ),
            if (food.isPopular)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Popular',
                    style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.onPrimary, fontSize: 8),
                  ),
                ),
              ),
          ],
        ),
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  food.name,
                  style: AppTextStyles.headline5Semibold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  food.category,
                  style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 12, color: AppColors.orange100),
                    const SizedBox(width: 2),
                    Text(
                      food.rating.toString(),
                      style: AppTextStyles.placeholder2Regular.copyWith(fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time_rounded, size: 12, color: AppColors.black60),
                    const SizedBox(width: 2),
                    Text(
                      '${food.preparationTime} min',
                      style: AppTextStyles.placeholder2Regular.copyWith(color: AppColors.black60, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${food.price.toStringAsFixed(2)}',
                      style: AppTextStyles.headline5Bold.copyWith(color: AppColors.primary),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add_rounded, size: 16, color: AppColors.onPrimary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
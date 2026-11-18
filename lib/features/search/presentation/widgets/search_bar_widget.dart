import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.onTap,
    this.hintText = 'Search for food, restaurants...',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey60),
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
            Icon(Icons.search_rounded, size: 22, color: AppColors.black60),
            const SizedBox(width: 12),
            Text(
              hintText,
              style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
            ),
            const Spacer(),
            Container(
              width: 1,
              height: 24,
              color: AppColors.lightGrey60,
            ),
            const SizedBox(width: 12),
            Icon(Icons.mic_none_rounded, size: 22, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
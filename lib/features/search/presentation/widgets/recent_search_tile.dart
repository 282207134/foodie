import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class RecentSearchTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RecentSearchTile({
    super.key,
    required this.query,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(Icons.history_rounded, size: 22, color: AppColors.black60),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                query,
                style: AppTextStyles.bodytext1Regular,
              ),
            ),
            InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Icon(Icons.close_rounded, size: 18, color: AppColors.black60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  final List<MenuSection> _sections = [
    MenuSection(
      title: 'Account',
      items: [
        MenuItem(icon: Icons.person_outline_rounded, title: 'My Profile', onTap: () {}),
        MenuItem(icon: Icons.location_on_outlined, title: 'My Addresses', onTap: () {}),
        MenuItem(icon: Icons.payment_outlined, title: 'Payment Methods', onTap: () {}),
        MenuItem(icon: Icons.local_offer_outlined, title: 'My Vouchers', onTap: () {}),
      ],
    ),
    MenuSection(
      title: 'Orders',
      items: [
        MenuItem(icon: Icons.receipt_long_rounded, title: 'Order History', onTap: () {}),
        MenuItem(icon: Icons.delivery_dining_rounded, title: 'Track Order', onTap: () {}),
        MenuItem(icon: Icons.favorite_outline_rounded, title: 'Favorites', onTap: () {}),
      ],
    ),
    MenuSection(
      title: 'Settings',
      items: [
        MenuItem(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
        MenuItem(icon: Icons.language_outlined, title: 'Language', onTap: () {}),
        MenuItem(icon: Icons.dark_mode_outlined, title: 'Dark Mode', onTap: () {}),
        MenuItem(icon: Icons.help_outline_rounded, title: 'Help & Support', onTap: () {}),
        MenuItem(icon: Icons.info_outline_rounded, title: 'About', onTap: () {}),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded, size: 24),
        ),
        title: Text('Menu', style: AppTextStyles.headline3Bold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // User Header
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [BoxShadow(color: AppColors.black10, blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      backgroundImage: const CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Doe', style: AppTextStyles.headline4Bold),
                          const SizedBox(height: 2),
                          Text('john.doe@email.com', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                        ],
                      ),
                    ),
                    TextButtonWidget(
                      text: 'Edit Profile',
                      onPressed: () => context.push('/edit-profile'),
                      style: AppTextStyles.placeholder1Medium,
                    ),
                  ],
                ),
              ),
            ),
            // Menu Sections
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return const SizedBox(height: 16);
                  }
                  final sectionIndex = index - 1;
                  if (sectionIndex >= _sections.length) {
                    return _buildLogoutSection();
                  }
                  return _buildSection(_sections[sectionIndex]);
                },
                childCount: _sections.length + 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(MenuSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            section.title,
            style: AppTextStyles.headline5Medium.copyWith(color: AppColors.black60),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.black10, blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: section.items.map((item) => _buildMenuItem(item)).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrey60.withValues(alpha: 0.5)),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(item.title, style: AppTextStyles.headline5Medium),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.black40),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.logout_rounded, color: AppColors.error, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text('Log Out', style: AppTextStyles.headline5Semibold.copyWith(color: AppColors.error)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Foodie v1.0.0',
          style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black40),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class MenuSection {
  final String title;
  final List<MenuItem> items;

  const MenuSection({required this.title, required this.items});
}

class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({required this.icon, required this.title, required this.onTap});
}
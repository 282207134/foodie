import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileMenuItem> _menuItems = [
    ProfileMenuItem(
      icon: Icons.person_outline_rounded,
      title: 'My Profile',
      subtitle: 'Manage your personal information',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.location_on_outlined,
      title: 'My Addresses',
      subtitle: 'Manage delivery addresses',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.payment_outlined,
      title: 'Payment Methods',
      subtitle: 'Manage your payment options',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.local_offer_outlined,
      title: 'My Vouchers',
      subtitle: 'View and manage your vouchers',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.history_rounded,
      title: 'Order History',
      subtitle: 'Track your past orders',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.favorite_outline_rounded,
      title: 'Favorites',
      subtitle: 'Your saved restaurants and dishes',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.settings_outlined,
      title: 'Settings',
      subtitle: 'App preferences and notifications',
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: Icons.help_outline_rounded,
      title: 'Help & Support',
      subtitle: 'FAQs, contact us, and more',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Profile Header
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
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
                    // Avatar & Name
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                              backgroundImage: const CachedNetworkImageProvider(
                                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppColors.surface, width: 2),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 14,
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: AppTextStyles.headline3Bold,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'john.doe@email.com',
                                style: AppTextStyles.bodytext1Regular.copyWith(color: AppColors.black60),
                              ),
                              const SizedBox(height: 8),
                              TextButtonWidget(
                                text: 'Edit Profile',
                                onPressed: () => context.push('/edit-profile'),
                                style: AppTextStyles.placeholder1Medium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Orders', '24'),
                        _buildDivider(),
                        _buildStatItem('Favorites', '12'),
                        _buildDivider(),
                        _buildStatItem('Vouchers', '5'),
                        _buildDivider(),
                        _buildStatItem('Reviews', '8'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Menu Items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return const SizedBox(height: 16);
                  }
                  if (index == _menuItems.length + 1) {
                    return _buildLogoutButton();
                  }
                  return _buildMenuItem(_menuItems[index - 1]);
                },
                childCount: _menuItems.length + 2,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.headline2Bold.copyWith(color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.lightGrey60,
    );
  }

  Widget _buildMenuItem(ProfileMenuItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item.icon, color: AppColors.primary, size: 24),
        ),
        title: Text(item.title, style: AppTextStyles.headline5Semibold),
        subtitle: Text(item.subtitle, style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.black40),
        onTap: item.onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: SecondaryButton(
        text: 'Log Out',
        onPressed: () => _showLogoutDialog(),
        leadingIcon: Icons.logout_rounded,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Log Out', style: AppTextStyles.headline4Bold),
        content: Text('Are you sure you want to log out?', style: AppTextStyles.bodytext1Regular),
        actions: [
          TextButtonWidget(
            text: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          PrimaryButton(
            text: 'Log Out',
            onPressed: () {
              Navigator.pop(context);
              // Handle logout
            },
            isFullWidth: false,
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
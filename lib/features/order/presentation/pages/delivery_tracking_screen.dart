import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final String orderId;

  const DeliveryTrackingScreen({super.key, required this.orderId});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  final List<TrackingStep> _steps = [
    TrackingStep(
      title: 'Order Confirmed',
      subtitle: 'Restaurant accepted your order',
      time: '12:30 PM',
      isCompleted: true,
      icon: Icons.check_circle_rounded,
    ),
    TrackingStep(
      title: 'Preparing',
      subtitle: 'Your food is being cooked',
      time: '12:35 PM',
      isCompleted: true,
      isActive: true,
      icon: Icons.restaurant_rounded,
    ),
    TrackingStep(
      title: 'Ready for Pickup',
      subtitle: 'Driver is on the way to restaurant',
      time: '1:00 PM',
      isCompleted: false,
      icon: Icons.local_shipping_rounded,
    ),
    TrackingStep(
      title: 'On the Way',
      subtitle: 'Driver is delivering your order',
      time: '1:10 PM',
      isCompleted: false,
      icon: Icons.delivery_dining_rounded,
    ),
    TrackingStep(
      title: 'Delivered',
      subtitle: 'Order delivered to your door',
      time: '1:25 PM',
      isCompleted: false,
      icon: Icons.home_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
        ),
        title: Text('Track Order', style: AppTextStyles.headline4Semibold),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push('/tracking-detail/${widget.orderId}'),
            icon: const Icon(Icons.info_outline_rounded, size: 24),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Map placeholder
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.lightGrey10,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _animationController.value * 2 * 3.14159,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.two_wheeler_rounded, color: AppColors.onPrimary, size: 20),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Driver is 5 min away',
                          style: AppTextStyles.headline5Medium.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Order Info
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: AppColors.black10, blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: AppColors.lightGrey10,
                          child: const Icon(Icons.restaurant_rounded, size: 30, color: AppColors.black40),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Burger King', style: AppTextStyles.headline5Semibold),
                            Text('123 Main Street', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$28.50', style: AppTextStyles.headline4Bold.copyWith(color: AppColors.primary)),
                          Text('Order #ORD-001', style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.chat_bubble_outline_rounded,
                          label: 'Chat',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.call_rounded,
                          label: 'Call',
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.person_outline_rounded,
                          label: 'Driver',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Tracking Steps
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  final isLast = index == _steps.length - 1;
                  return _buildTrackingStep(step, index, isLast);
                },
              ),
            ),
            // Bottom action
            Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                text: 'View Details',
                onPressed: () => context.push('/tracking-detail/${widget.orderId}'),
                leadingIcon: Icons.arrow_forward_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(height: 8),
            Text(label, style: AppTextStyles.placeholder1Medium),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(TrackingStep step, int index, bool isLast) {
    final isCompleted = step.isCompleted;
    final isActive = step.isActive == true;
    
    Color iconColor;
    Color lineColor;
    if (isCompleted) {
      iconColor = AppColors.success100;
      lineColor = AppColors.success100;
    } else if (isActive) {
      iconColor = AppColors.primary;
      lineColor = AppColors.primary.withValues(alpha: 0.3);
    } else {
      iconColor = AppColors.lightGrey60;
      lineColor = AppColors.lightGrey60;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line & icon
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted || isActive ? iconColor : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCompleted || isActive ? iconColor : AppColors.lightGrey60,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check_rounded, size: 14, color: AppColors.onPrimary)
                  : Icon(step.icon, size: 14, color: isActive ? AppColors.onPrimary : AppColors.lightGrey60),
            ),
            if (!isLast)
              Expanded(
                child: Container(
                  width: 2,
                  color: lineColor,
                  margin: const EdgeInsets.only(left: 11),
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Step content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      step.title,
                      style: AppTextStyles.headline5Semibold.copyWith(
                        color: isCompleted || isActive ? AppColors.onSurface : AppColors.black60,
                      ),
                    ),
                    Text(
                      step.time,
                      style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: AppTextStyles.placeholder1Regular.copyWith(color: AppColors.black60),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TrackingStep {
  final String title;
  final String subtitle;
  final String time;
  final bool isCompleted;
  final bool isActive;
  final IconData icon;

  const TrackingStep({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isCompleted,
    this.isActive = false,
    required this.icon,
  });
}
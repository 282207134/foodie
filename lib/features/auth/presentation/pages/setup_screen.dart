import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SetupStep> _steps = [
    SetupStep(
      title: 'Enable Location',
      description: 'Allow Foodie to access your location to find restaurants near you and deliver faster.',
      icon: Icons.location_on_rounded,
      buttonText: 'Enable Location',
    ),
    SetupStep(
      title: 'Notifications',
      description: 'Get updates on your orders, special offers, and new restaurant openings.',
      icon: Icons.notifications_rounded,
      buttonText: 'Allow Notifications',
    ),
    SetupStep(
      title: 'Payment Method',
      description: 'Add your preferred payment method for quick and secure checkout.',
      icon: Icons.payment_rounded,
      buttonText: 'Add Payment Method',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: List.generate(
                  _steps.length,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index < _steps.length - 1 ? 8 : 0),
                      decoration: BoxDecoration(
                        color: index <= _currentPage ? AppColors.primary : AppColors.lightGrey60,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Icon(step.icon, size: 70, color: AppColors.primary),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          step.title,
                          style: AppTextStyles.headline2Bold.copyWith(fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          step.description,
                          style: AppTextStyles.bodytext1Regular.copyWith(
                            color: AppColors.black60,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  PrimaryButton(
                    text: _currentPage == _steps.length - 1 ? 'Get Started' : _steps[_currentPage].buttonText,
                    onPressed: _nextStep,
                    trailingIcon: _currentPage == _steps.length - 1 ? null : Icons.arrow_forward_rounded,
                  ),
                  if (_currentPage < _steps.length - 1) ...[
                    const SizedBox(height: 16),
                    TextButtonWidget(
                      text: 'Skip for now',
                      onPressed: () => _pageController.jumpToPage(_steps.length - 1),
                      color: AppColors.black60,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SetupStep {
  final String title;
  final String description;
  final IconData icon;
  final String buttonText;

  const SetupStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
  });
}
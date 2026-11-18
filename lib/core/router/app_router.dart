import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/auth/presentation/pages/setup_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/food_detail_screen.dart';
import '../../features/search/presentation/pages/search_screen.dart';
import '../../features/search/presentation/pages/search_result_screen.dart';
import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/order/presentation/pages/order_history_screen.dart';
import '../../features/order/presentation/pages/delivery_tracking_screen.dart';
import '../../features/order/presentation/pages/delivery_detail_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/location/presentation/pages/my_location_screen.dart';
import '../../features/voucher/presentation/pages/voucher_screen.dart';
import '../../features/voucher/presentation/pages/voucher_detail_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/home/presentation/pages/side_menu_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      name: 'signIn',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      name: 'signUp',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/setup',
      name: 'setup',
      builder: (context, state) => const SetupScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/food-detail/:id',
      name: 'foodDetail',
      builder: (context, state) => FoodDetailScreen(foodId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/search-result',
      name: 'searchResult',
      builder: (context, state) => const SearchResultScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/orders',
      name: 'orderHistory',
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/tracking/:orderId',
      name: 'deliveryTracking',
      builder: (context, state) => DeliveryTrackingScreen(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
      path: '/tracking-detail/:orderId',
      name: 'deliveryDetail',
      builder: (context, state) => DeliveryDetailScreen(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      name: 'editProfile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/my-location',
      name: 'myLocation',
      builder: (context, state) => const MyLocationScreen(),
    ),
    GoRoute(
      path: '/vouchers',
      name: 'vouchers',
      builder: (context, state) => const VoucherScreen(),
    ),
    GoRoute(
      path: '/voucher-detail/:id',
      name: 'voucherDetail',
      builder: (context, state) => VoucherDetailScreen(voucherId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
      path: '/side-menu',
      name: 'sideMenu',
      builder: (context, state) => const SideMenuScreen(),
    ),
  ],
);
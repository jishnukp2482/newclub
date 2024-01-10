import 'package:get/get.dart';
import 'package:newclub/presentaion/pages/bottom_nav.dart';
import 'package:newclub/presentaion/pages/cart/cartpage.dart';
import 'package:newclub/presentaion/pages/kot/kot_screen.dart';
import 'package:newclub/presentaion/pages/splash.dart';

import '../pages/auth/loginpage.dart';

import '../pages/dashboard/dashboard.dart';
import '../pages/kot/item_screen.dart';
import '../pages/kot/memeber_page.dart';
import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.splash, page: () => Splashscreen()),
    GetPage(
      name: AppPages.loginpage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppPages.dashboard,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: AppPages.bottomnav,
      page: () => BottomNav(),
    ),
    GetPage(
      name: AppPages.kotpage,
      page: () => const KotPage(),
    ),
    GetPage(name: AppPages.itempage, page: () => ItemsScreen()),
    GetPage(
      name: AppPages.memeberGuestPage,
      page: () => MemeberGuestPage(),
    ),
    GetPage(name: AppPages.cartpage, page: () => CartPage()),
  ];
}

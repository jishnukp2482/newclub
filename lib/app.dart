import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newclub/injector.dart';
import 'package:newclub/presentaion/manager/controller/auth/auth_proivder.dart';
import 'package:newclub/presentaion/manager/controller/bottom_nav_provider.dart';
import 'package:newclub/presentaion/manager/controller/cart/cartProvider.dart';
import 'package:newclub/presentaion/manager/controller/dashboard_provider.dart';
import 'package:newclub/presentaion/manager/controller/kotandbot/kot_provider.dart';
import 'package:newclub/presentaion/manager/controller/kotandbot/memeber_provider.dart';
import 'package:provider/provider.dart';
import 'presentaion/routes/app_pages.dart';
import 'presentaion/routes/app_routes.dart';
import 'presentaion/themes/apptheme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Authprovider(sl()),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashBoardproivder(),
        ),
        ChangeNotifierProvider(
          create: (context) => KotProvider(sl()),
        ),
        ChangeNotifierProvider(
          create: (context) => MemberGuestProvider(sl(), sl(), sl()),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(sl()),
        ),
      ],
      child: GetMaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.splash,
        getPages: AppRoutes.routes,
      ),
    );
  }
}

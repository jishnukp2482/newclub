import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newclub/presentaion/pages/cart/cartpage.dart';

import '../../pages/dashboard/dashboard.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    if (index == 3) {
      SystemNavigator.pop();
    }
    selectedIndex = index;
    notifyListeners();
  }

  final List bodys = [
    DashboardScreen(),
    Card(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Text("pending"),
      ),
    ),
    CartPage(),
    Card(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Text("logout"),
      ),
    ),
  ];
}

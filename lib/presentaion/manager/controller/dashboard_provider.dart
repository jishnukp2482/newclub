import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newclub/domain/entities/dashboard/carousel_Modal.dart';
import 'package:newclub/domain/entities/dashboard/dashboard_Grid_Modal.dart';

import '../../routes/app_pages.dart';
import '../../themes/app_assets.dart';
import '../../themes/appcolors.dart';

class DashBoardproivder extends ChangeNotifier {
  final dashboarditems = <DashBoardGridModal>[
    DashBoardGridModal(IcoFontIcons.foodCart, "KOT", AppColors.red, () {
      Get.toNamed(AppPages.memeberGuestPage);
    }),
    DashBoardGridModal(
        MdiIcons.clipboardListOutline, "Order", AppColors.blue, () {}),
    DashBoardGridModal(Icons.receipt, "Recharge", AppColors.green, () {}),
    DashBoardGridModal(MdiIcons.bookOutline, "Report", AppColors.orange, () {}),
  ];
  //Carousel Slider
  final List<CarouselModel> carouselitems = [
    CarouselModel(AppAssets.caurosel1),
    CarouselModel(AppAssets.caurosel2),
    CarouselModel(AppAssets.caurosel3),
    CarouselModel(AppAssets.caurosel4),
  ];
}

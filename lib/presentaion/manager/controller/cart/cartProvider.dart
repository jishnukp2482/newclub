import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newclub/core/respose_classify.dart';
import 'package:newclub/data/remote/modals/request/cartsaveRequestModal.dart';
import 'package:newclub/data/remote/modals/response/cartSaveResponseModal.dart';
import 'package:newclub/domain/entities/cart/cartOrderModel.dart';
import 'package:newclub/presentaion/routes/app_pages.dart';
import 'package:newclub/presentaion/widgets/custome_alertdialogue.dart';

import '../../../../domain/usecase/cart/cartSaveUseCase.dart';

class CartProvider extends ChangeNotifier {
  final CartSaveUseCase cartSaveUseCase;

  CartProvider(this.cartSaveUseCase);
  final cartItemList = <CartOrderModel>[];
  clearItemList() {
    cartItemList.clear();

    Get.back();
    notifyListeners();
  }

  bool cartLoading = false;
  addToCart(String item, String itemCode, String orderType, String qty,
      String itemrate, String total, String description) {
    cartLoading = true;
    CartOrderModel model = CartOrderModel(
      item,
      itemCode,
      qty,
      orderType,
      itemrate,
      total,
      description,
    );
    debugPrint("add to cart item name==${item}");

    cartItemList.add(model);
    debugPrint("new item in cart =adding item ${model.item}");
    debugPrint("add to cart success");

    cartItemList.sort((a, b) {
      return a.item.compareTo(b.item);
    });
    cartLoading = false;
    notifyListeners();
  }

  removeFromCart(CartOrderModel cartOrderModel) {
    cartLoading = true;
    CartOrderModel model = cartOrderModel;
    int exisitingIndex = cartItemList.indexWhere((element) =>
        element.item == model.item &&
        element.total == element.total &&
        element.itemCode == model.itemCode &&
        model.qty == model.qty &&
        element.orderType == model.orderType &&
        element.itemrate == element.itemrate);
    if (exisitingIndex != -1) {
      cartItemList.removeAt(exisitingIndex);
    }
    debugPrint("removed from cart");
    cartLoading = false;
    notifyListeners();
  }

  ResponseClassify<CartSaveResponseModal> cartsaveState =
      ResponseClassify<CartSaveResponseModal>.error("");
  ResponseClassify<CartSaveResponseModal> get cartsaveStateResponse =>
      cartsaveState;
  bool cartsaveLoading = false;
  cartSave(
    String counterCode,
    String memberType,
    String bioCardNo,
    String memberNo,
    String groupName,
    String waiterCode,
    String rateType,
    String remarks,
    String makerId,
    String tableNo,
  ) async {
    cartsaveState = ResponseClassify.loading();
    cartsaveLoading = true;
    notifyListeners();
    try {
      List<Map<String, dynamic>> jsonList =
          cartItemList.map((e) => e.tojosn()).toList();
      String jsonString = jsonEncode(jsonList);
      debugPrint("cart save ======cart save ");
      debugPrint("counter coder ======$counterCode ");
      debugPrint("membertype ======$memberType ");
      debugPrint("member no ======$memberNo ");
      debugPrint("biocard no ======$bioCardNo ");
      debugPrint("groupname ======$groupName ");
      debugPrint("waitercode ======$waiterCode ");
      debugPrint("ratetype ======$rateType ");
      debugPrint("remarks ======$remarks ");
      debugPrint("itemsjson ======$jsonString ");
      debugPrint("makerid ======$makerId ");
      debugPrint("tableno ======$tableNo ");

      cartsaveState = ResponseClassify.completed(await cartSaveUseCase.call(
          CartSaveRequestModal(
              counterCode: counterCode,
              memberType: memberType,
              bioCardNo: bioCardNo,
              memberNo: memberNo,
              groupName: groupName,
              waiterCode: waiterCode,
              rateType: rateType,
              remarks: remarks,
              itemsJson: jsonString,
              makerId: makerId,
              tableNo: tableNo,
              makingTime: DateTime.now().toString())));
      cartsaveLoading = false;
      notifyListeners();
      customAlertDialogue(
          title: "Success",
          content: "${cartsaveState.data!.message}",
          txtbuttonName1: "ok",
          txtbutton1Action: () {
            cartItemList.clear();
            notifyListeners();
            Get.offAllNamed(AppPages.dashboard);
          });
    } catch (e) {
      cartsaveState = ResponseClassify.error("$e");
      notifyListeners();
    }
  }
}

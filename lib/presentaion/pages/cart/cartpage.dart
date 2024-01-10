import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newclub/core/respose_classify.dart';
import 'package:newclub/presentaion/manager/controller/cart/cartProvider.dart';
import 'package:newclub/presentaion/manager/controller/kotandbot/memeber_provider.dart';
import 'package:newclub/presentaion/routes/LocalStoragename.dart';
import 'package:newclub/presentaion/themes/appcolors.dart';
import 'package:newclub/presentaion/widgets/custome_alertdialogue.dart';
import 'package:provider/provider.dart';

import '../../widgets/cart/cartitem.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final memeberguestProvider = Provider.of<MemberGuestProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final box = GetStorage();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.black,
            )),
        title: Text(
          "Cart",
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
              builder: (context, value, child) =>
                  cartProvider.cartItemList.isEmpty
                      ? SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            customAlertDialogue(
                                title: "Alert",
                                content: "Are you sure to clear Items in cart",
                                txtbuttonName1: "cancel",
                                txtbutton1Action: () {
                                  Get.back();
                                },
                                txtbuttonName2: "yes",
                                txtbutton2Action: () {
                                  cartProvider.clearItemList();
                                });
                          },
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: AppColors.black,
                          ))),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          CartItemMenu(),
          SizedBox(
            height: 10,
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) => cartProvider
                    .cartItemList.isEmpty
                ? SizedBox.shrink()
                : SizedBox(
                    height: 45,
                    width: width,
                    child: Consumer<CartProvider>(
                      builder: (context, value, child) => cartProvider
                              .cartsaveLoading
                          ? SizedBox(
                              height: 40,
                              width: 20,
                              child: Center(child: CircularProgressIndicator()))
                          : ElevatedButton(
                              onPressed: () {
                                cartProvider.cartSave(
                                    memeberguestProvider.counterNocontroller,
                                    memeberguestProvider
                                        .memeberOrGuestcontroller,
                                    memeberguestProvider
                                        .biocardNoTexteditingCntlr.text,
                                    memeberguestProvider
                                        .memberNoTextedTexteditingCntlr.text,
                                    memeberguestProvider.groupcontroller,
                                    memeberguestProvider.waiterController,
                                    memeberguestProvider.ratecontroller,
                                    memeberguestProvider.remarkcontroller.text,
                                    box.read(LocalStorageNames.usernameKEY),
                                    memeberguestProvider.tablecontroller.text);
                              },
                              child: Text("place order"),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                  foregroundColor: AppColors.white),
                            ),
                    )),
          )
        ],
      ),
    ));
  }
}

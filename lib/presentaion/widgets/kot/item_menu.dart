import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:newclub/data/remote/modals/response/kotItemsResponseModal.dart';
import 'package:newclub/presentaion/manager/controller/kotandbot/kot_provider.dart';
import 'package:newclub/presentaion/routes/app_pages.dart';
import 'package:newclub/presentaion/themes/app_assets.dart';
import 'package:newclub/presentaion/widgets/custome_alertdialogue.dart';
import 'package:provider/provider.dart';
import '../../manager/controller/cart/cartProvider.dart';
import '../../themes/appcolors.dart';

class ItemModalMenu extends StatefulWidget {
  const ItemModalMenu({super.key});

  @override
  State<ItemModalMenu> createState() => _ItemModalMenuState();
}

class _ItemModalMenuState extends State<ItemModalMenu> {
  @override
  Widget build(BuildContext context) {
    final kotcontroller = Provider.of<KotProvider>(context);
    return Consumer<KotProvider>(
      builder: (context, value, child) => kotcontroller.issubItemLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              key: UniqueKey(),
              shrinkWrap: true,
              itemCount: kotcontroller.filteredSearchItemslist.length,
              itemBuilder: (context, index) {
                return Consumer<KotProvider>(
                  builder: (context, value, child) =>
                      kotcontroller.issubItemLoading2
                          ? const SizedBox.shrink()
                          : ItemModalItem(
                              itemModal:
                                  kotcontroller.filteredSearchItemslist[index]),
                );
              },
            ),
    );
  }
}

class ItemModalItem extends StatefulWidget {
  const ItemModalItem({
    super.key,
    required this.itemModal,
  });
  final ItemsDatum itemModal;

  @override
  State<ItemModalItem> createState() => _ItemModalItemState();
}

class _ItemModalItemState extends State<ItemModalItem> {
  final ValueNotifier<double> price = ValueNotifier<double>(0);
  final ValueNotifier<String> selectedType = ValueNotifier<String>("");
  final quantitytextValueNotifier = ValueNotifier<String>('');
  final descriptiontextValueNotifier = ValueNotifier<String>('');
  double selectedprice = 0.0;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final kotProvider = Provider.of<KotProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SizedBox(
          height: height * 0.26,
          width: width,
          child: Card(
            color: AppColors.white,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.01, width * 0.01, width * 0.05),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.007, top: height * 0.005),
                        child: Text(
                          widget.itemModal.itemName,
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Container(
                      //   height: height * 0.14,
                      //   width: width * 0.3,
                      //   decoration: BoxDecoration(
                      //       borderRadius: const BorderRadius.only(
                      //           bottomLeft: Radius.circular(10)),
                      //       image: DecorationImage(
                      //           image: AssetImage(AppAssets.beer1),
                      //           fit: BoxFit.cover)),
                      // )

                      SizedBox(
                        height: height * 0.005,
                      ),
                      SizedBox(
                        height: height * 0.04,
                        width: width * 0.8,
                        child: DropdownSearch<OrderType>(
                          // autoValidateMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value == null) {
                              return "Required Field";
                            }
                            return null;
                          },
                          itemAsString: (item) => item.name,
                          enabled: true,
                          popupProps: const PopupProps.menu(fit: FlexFit.loose),
                          items: [widget.itemModal.orderType] ?? [],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              isDense: false,
                              labelText: "select",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.black,
                                width: 0.3,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.blue,
                                width: 0.3,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: AppColors.black,
                                width: 0.3,
                              )),
                              disabledBorder: OutlineInputBorder(),
                              hintText: "Serve",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.all(5),
                            ),
                          ),
                          onChanged: (value) {
                            final item = widget.itemModal.itemRate;

                            debugPrint("price:${item}");
                            if (quantitytextValueNotifier.value == "") {
                              quantitytextValueNotifier.value = "1";
                            }
                            price.value = item;
                            selectedprice = 0.0;
                            selectedprice = item;
                            debugPrint(
                                "selected type in dropdown==${value.toString()}");
                            String result =
                                value.toString().replaceFirst('OrderType.', '');
                            selectedType.value = result;
                            debugPrint(
                                "selected type in dropdown==${selectedType.value.toString()}");
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      //quantity
                      Row(
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: quantitytextValueNotifier,
                            builder: (context, value, child) {
                              final FocusNode _focusNode = FocusNode();

                              return SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.4,
                                  child: TextFormField(
                                    focusNode: _focusNode,
                                    controller: kotProvider.qtycontroller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: AppColors.black,
                                        width: 0.3,
                                      )),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: AppColors.blue,
                                        width: 0.3,
                                      )),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: AppColors.black,
                                        width: 0.3,
                                      )),
                                      disabledBorder: OutlineInputBorder(),
                                      hintText:
                                          quantitytextValueNotifier.value == ""
                                              ? "quantity "
                                              : quantitytextValueNotifier.value,
                                      hintStyle: TextStyle(
                                        color:
                                            quantitytextValueNotifier.value ==
                                                    ""
                                                ? AppColors.grey
                                                : AppColors.black,
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNode);
                                    },
                                    onChanged: (onchangedvalue) {
                                      debugPrint(
                                          "onchagedvalue==$onchangedvalue");
                                      quantitytextValueNotifier.value =
                                          onchangedvalue;
                                      debugPrint(
                                          "onchanged value==${quantitytextValueNotifier.value}");

                                      debugPrint(
                                          "qty==${quantitytextValueNotifier.value}");
                                      debugPrint("price==${selectedprice}");
                                      double currentprice = selectedprice;

                                      int qty = int.tryParse(
                                              quantitytextValueNotifier
                                                  .value) ??
                                          0;
                                      double subTotal = (currentprice * qty);
                                      price.value = subTotal;

                                      debugPrint("SubTotal=$subTotal");
                                    },
                                  ));
                            },
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          ValueListenableBuilder<double>(
                            valueListenable: price,
                            builder: (context, value, child) {
                              return SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.38,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    readOnly:
                                        widget.itemModal.rateEditable == false
                                            ? true
                                            : false,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: AppColors.black,
                                          width: 0.3,
                                        )),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: AppColors.blue,
                                          width: 0.3,
                                        )),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: AppColors.black,
                                          width: 0.3,
                                        )),
                                        disabledBorder:
                                            const OutlineInputBorder(),
                                        hintText: "${value} ",
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(5)),
                                  ));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.007,
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: descriptiontextValueNotifier,
                        builder: (context, value, child) {
                          return SizedBox(
                              height: height * 0.04,
                              width: width * 0.8,
                              child: TextFormField(
                                maxLength: 25,
                                buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        required bool isFocused}) =>
                                    null,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: AppColors.black,
                                      width: 0.3,
                                    )),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: AppColors.blue,
                                      width: 0.3,
                                    )),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: AppColors.black,
                                      width: 0.3,
                                    )),
                                    disabledBorder: const OutlineInputBorder(),
                                    hintText: "Enter Description ",
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    contentPadding: const EdgeInsets.all(5)),
                                onChanged: (value) {
                                  descriptiontextValueNotifier.value = value;
                                },
                              ));
                        },
                      ),
                      SizedBox(
                        height: height * 0.0054,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ///Add button
                            GestureDetector(
                              onTap: () {
                                if (selectedType.value.isEmpty) {
                                  customAlertDialogue(
                                      title: "Alert",
                                      content: "please select a type",
                                      txtbuttonName1: "Tryagain",
                                      txtbutton1Action: () {
                                        Get.back();
                                      });
                                } else {
                                  cartProvider.addToCart(
                                      widget.itemModal.itemName,
                                      widget.itemModal.itemCode,
                                      selectedType.value,
                                      quantitytextValueNotifier.value
                                          .toString(),
                                      widget.itemModal.itemRate.toString(),
                                      price.value.toString(),
                                      descriptiontextValueNotifier.value);
                                  customAlertDialogue(
                                      title: "",
                                      content: " item added to cart",
                                      txtbuttonName1: "View Cart",
                                      txtbuttonName2: "Back",
                                      txtbutton1Action: () {
                                        Get.toNamed(AppPages.cartpage);
                                      },
                                      txtbutton2Action: () {
                                        Get.back();
                                      });
                                }
                              },
                              child: SizedBox(
                                height: height * 0.03,
                                child: Consumer<CartProvider>(
                                  builder: (context, value, child) =>
                                      cartProvider.cartLoading
                                          ? CircularProgressIndicator()
                                          : ElevatedButton(
                                              onPressed: null,
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.red,
                                                  foregroundColor:
                                                      AppColors.white),
                                              child: const Text("Add"),
                                            ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

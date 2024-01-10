import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newclub/core/respose_classify.dart';
import 'package:newclub/data/remote/modals/request/loginRequestModal.dart';
import 'package:newclub/domain/usecase/auth/LoginUseCase.dart';
import 'package:newclub/presentaion/routes/LocalStoragename.dart';
import 'package:newclub/presentaion/routes/app_pages.dart';
import 'package:newclub/presentaion/widgets/custome_alertdialogue.dart';

import '../../../../data/remote/modals/response/loginresponseModal.dart';

class Authprovider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  Authprovider(this.loginUseCase);
  final box = GetStorage();
  final userNamecontroller = TextEditingController();
  final userpassword = TextEditingController();
  ResponseClassify<LoginResponseModal> loginstate =
      ResponseClassify<LoginResponseModal>.error("");
  ResponseClassify<LoginResponseModal> get loginresponse => loginstate;
  getLogin() async {
    loginstate = ResponseClassify.loading();
    notifyListeners();
    try {
      loginstate = ResponseClassify.completed(await loginUseCase.call(
          LoginRequestModal(
              userName: userNamecontroller.text, password: userpassword.text)));
      box.write(
          LocalStorageNames.usernameKEY, loginstate.data!.data.first.userName);
      // box.write(LocalStorageNames.makerid, loginstate.data!.data.first.)
      notifyListeners();
      Get.toNamed(AppPages.bottomnav);
    } catch (e) {
      loginstate = ResponseClassify.error("$e");
      customAlertDialogue(
          title: "Error",
          content: "${e}",
          txtbuttonName1: "Try Again",
          txtbutton1Action: () {
            Get.back();
          });
      notifyListeners();
    }
    notifyListeners();
  }
}

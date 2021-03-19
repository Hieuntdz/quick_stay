import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/data/repository.dart';
import 'package:quick_stay_flutter/app/routes/app_pages.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';

class LoginController extends GetxController {

  TextEditingController editingPhoneNumberController = TextEditingController();
  TextEditingController editingPassWordController = TextEditingController();

  Repository _repository = Repository();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> login(String phoneNumber, String passWord) async {
    Logger.debug("start");
    Logger.debug("phone $phoneNumber  password $passWord");
    // if (!validateMobile(phoneNumber) || passWord.isEmpty) {
    //   Logger.debug("invalid phone number or password");
    //   Get.showSnackbar(GetBar(message: "invalid phone number or password",duration: Duration(milliseconds: 500),));
    // } else {
      // LoginResponse baseResponse = await _repository.login(
      //     phoneNumber, passWord);
      // if (baseResponse != null && baseResponse.success == 1) {
        Get.to(Routes.HOME);
//       } else {
// //        setToastMessage(baseResponse.message);
//       }
//     }
  }

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}

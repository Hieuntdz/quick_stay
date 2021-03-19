import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_cli/core/locales.g.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:quick_stay_flutter/app/utils/hex_color.dart';
import 'package:quick_stay_flutter/app/utils/scroll_column_expandable.dart';

import '../controllers/login_controller.dart';
import 'login_textfield_form.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  Widget _body() {
    return Ink(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(left: 21, right: 21),
        child: Stack(
          children: [
            ScrollColumnExpandable(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                InkWell(
                  child: Image.asset(
                    "assets/images/ic_close_white.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                 "dgfdgdfgdg",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDimen.defaultTextBigSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 104,
                ),
                _formLogin(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _signUp(),
            ),
          ],
        ));
  }

  Widget _formLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginTextFiledForm('language.lang.getPhoneNumberText',
            controller.editingPhoneNumberController),
        SizedBox(
          height: 16,
        ),
        LoginTextFiledForm(LocaleKeys.ask_company_domain,
            controller.editingPassWordController),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              color: HexColor("#E56024"),
              highlightColor: Colors.grey,
              splashColor: Colors.grey,
              onPressed: () {
                controller.login(controller.editingPhoneNumberController.text,
                    controller.editingPassWordController.text);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDimen.defaultTextNormalSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              "Password",
              style: TextStyle(color: Colors.white,
                  fontSize: AppDimen.defaultTextNormalSize),
            ),
          ],
        ),
      ],
    );
  }

  Widget _signUp() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ko co tk",
            style: TextStyle(
                color: Colors.black, fontSize: AppDimen.defaultTextNormalSize),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white, fontSize: AppDimen.defaultTextNormalSize),
          ),
        ],
      ),
    );
  }
}

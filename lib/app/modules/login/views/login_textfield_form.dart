import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';


class LoginTextFiledForm extends StatelessWidget {

  final String title;
  final TextEditingController controller;
  LoginTextFiledForm(this.title,this.controller);

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                TextStyle(color: Colors.white, fontSize: AppDimen.defaultTextNormalSize, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 14),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: Color(0xE5E5E5), width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(color: Color(0xE5E5E5), width: 1)),
          ),
          style: TextStyle(
            color: Colors.white,
          ),
          focusNode: FocusNode(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/promote_page_controller.dart';

class PromotePageView extends GetView<PromotePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PromotePageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PromotePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

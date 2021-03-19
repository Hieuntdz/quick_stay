import 'dart:core';

class LoginResponse {
  int success;
  String message;
  String data;

  LoginResponse(this.success, this.message, this.data);

  LoginResponse.fromJson(Map<String, dynamic> jsonData) {
    success = jsonData['success'];
    message = jsonData['message'];
    data = jsonData['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}

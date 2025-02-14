import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class LoginController extends GetxController {
  final PocketBaseService pbService = Get.find();
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;
      await pbService.pb.collection('users').authWithPassword(
            email.value,
            password.value,
          );
      await Future.delayed(const Duration(milliseconds: 100));
      Get.offAllNamed('/home');
    } on ClientException catch (e) {
      Get.snackbar(
        '登录失败',
        e.response['message'] ?? '未知错误',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

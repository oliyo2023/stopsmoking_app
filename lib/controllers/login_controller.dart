import 'package:get/get.dart';
import 'package:jieyan_app/providers/user_provider.dart';

class LoginController extends GetxController {
  final UserProvider _userProvider = Get.find();

  // 登录状态
  final RxBool isLoading = false.obs;

  // 登录
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        '错误',
        '请输入邮箱和密码',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isLoading.value = true;
    try {
      await _userProvider.login(email, password);
    } finally {
      isLoading.value = false;
    }
  }

  // 注册
  Future<void> register(String email, String password, String nickname) async {
    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      Get.snackbar(
        '错误',
        '请填写所有必填信息',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isLoading.value = true;
    try {
      await _userProvider.register(email, password, nickname);
    } finally {
      isLoading.value = false;
    }
  }

  // 重置密码
  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar(
        '错误',
        '请输入邮箱',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isLoading.value = true;
    try {
      await _userProvider.resetPassword(email);
    } finally {
      isLoading.value = false;
    }
  }
}

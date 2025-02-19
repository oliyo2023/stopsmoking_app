import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';

class UserProvider extends GetxController {
  final PocketBaseService _pbService = Get.find();

  // 用户认证状态
  final RxBool isLoggedIn = false.obs;

  // 用户信息
  final Rx<RecordModel?> userRecord = Rx<RecordModel?>(null);

  // 用户昵称
  final RxString nickname = ''.obs;

  // 用户头像URL
  final RxString avatarUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化时检查登录状态
    checkLoginStatus();
    // 监听认证状态变化
    ever(isLoggedIn, (_) => onLoginStatusChanged());
  }

  // 检查登录状态
  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _pbService.pb.authStore.isValid;
    if (isLoggedIn.value) {
      await fetchUserProfile();
    }
  }

  // 获取用户资料
  Future<void> fetchUserProfile() async {
    try {
      final record = await _pbService.pb
          .collection('users')
          .getOne(_pbService.pb.authStore.model!.id);
      userRecord.value = record;
      nickname.value = record.data['nickname'] ?? '';
      avatarUrl.value = record.data['avatar'] ?? '';
    } catch (e) {
      Get.snackbar(
        '错误',
        '获取用户资料失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // 登录状态变化处理
  void onLoginStatusChanged() {
    if (!isLoggedIn.value) {
      // 清除用户数据
      userRecord.value = null;
      nickname.value = '';
      avatarUrl.value = '';
    }
  }

  // 更新用户资料
  Future<void> updateProfile({String? newNickname}) async {
    try {
      final data = <String, dynamic>{};
      if (newNickname != null) {
        data['nickname'] = newNickname;
      }

      final updated = await _pbService.pb
          .collection('users')
          .update(_pbService.pb.authStore.model!.id, body: data);

      userRecord.value = updated;
      if (newNickname != null) {
        nickname.value = newNickname;
      }

      Get.snackbar(
        '成功',
        '个人资料已更新',
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '更新个人资料失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // 登录
  Future<void> login(String email, String password) async {
    try {
      await _pbService.pb.collection('users').authWithPassword(
            email,
            password,
          );
      isLoggedIn.value = true;
      await fetchUserProfile();
      Get.offAllNamed('/home');
    } on ClientException catch (e) {
      Get.snackbar(
        '错误',
        e.response['message'] ?? '登录失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      rethrow;
    }
  }

  // 注册
  Future<void> register(String email, String password, String nickname) async {
    try {
      final body = <String, dynamic>{
        'email': email,
        'password': password,
        'passwordConfirm': password,
        'nickname': nickname,
      };

      await _pbService.pb.collection('users').create(body: body);
      await login(email, password);
    } on ClientException catch (e) {
      Get.snackbar(
        '错误',
        e.response['message'] ?? '注册失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      rethrow;
    }
  }

  // 重置密码
  Future<void> resetPassword(String email) async {
    try {
      await _pbService.pb.collection('users').requestPasswordReset(email);
      Get.snackbar(
        '成功',
        '重置密码邮件已发送',
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } on ClientException catch (e) {
      Get.snackbar(
        '错误',
        e.response['message'] ?? '重置密码失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      rethrow;
    }
  }

  // 登出
  void logout() {
    _pbService.pb.authStore.clear();
    isLoggedIn.value = false;
  }

  // 登录
  Future<void> signIn(String email, String password) async {
    try {
      await _pbService.pb.collection('users').authWithPassword(
            email,
            password,
          );
      isLoggedIn.value = true;
      await fetchUserProfile();
      Get.offAllNamed('/home');
    } on ClientException catch (e) {
      Get.snackbar(
        '错误',
        e.response['message'] ?? '登录失败',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      rethrow;
    }
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final _isChatVisible = RxBool(true);
  bool get isChatVisible => _isChatVisible.value;

  @override
  void onInit() {
    super.onInit();
    loadChatVisibility();
  }

  loadChatVisibility() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isChatVisible.value = (prefs.getBool('isChatVisible') ?? true);
  }

  saveChatVisibility(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isChatVisible', value);
      _isChatVisible(value);
    } catch (e) {
      // TODO: Show error message to user
    }
  }

  void toggleChatVisibility() {
    saveChatVisibility(!isChatVisible);
  }
}

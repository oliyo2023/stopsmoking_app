import 'package:get/get.dart';
import 'package:jieyan_app/services/pocketbase_service.dart';
import 'package:jieyan_app/models/checkin_model.dart';
import 'package:table_calendar/table_calendar.dart';

class InteractiveCalendarController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  final PocketBaseService _pbService = Get.find();
  List<CheckinModel> checkinRecords = [];

  @override
  void onInit() {
    super.onInit();
    // 延迟 500 毫秒调用 fetchCheckinData 方法
    Future.delayed(Duration(milliseconds: 500), () {
      fetchCheckinData();
    });
  }

  Future<void> fetchCheckinData() async {
    final userId = _pbService.pb.authStore.model.id;
    if (userId == null) {
      // 用户未登录，直接返回
      return;
    }
    final now = focusedDay;
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final records = await _pbService.getCheckinRecords(
        userId, firstDayOfMonth, lastDayOfMonth);
    checkinRecords = records;
    update(); // 更新 GetBuilder 组件状态
  }

  void previousMonth() {
    focusedDay =
        DateTime(focusedDay.year, focusedDay.month - 1, focusedDay.day);
    selectedDay = focusedDay;
    fetchCheckinData();
  }

  void nextMonth() {
    focusedDay =
        DateTime(focusedDay.year, focusedDay.month + 1, focusedDay.day);
    selectedDay = focusedDay;
    fetchCheckinData();
  }
}

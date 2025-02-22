class CheckinModel {
  final String id;
  final String date;
  final int smokeCount;
  final String reason;
  final String userId;

  CheckinModel({
    required this.id,
    required this.date,
    required this.smokeCount,
    required this.reason,
    required this.userId,
  });

  factory CheckinModel.fromJson(Map<String, dynamic> json) {
    return CheckinModel(
      id: json['id'],
      date: json['date'],
      smokeCount: json['smokeCount'],
      reason: json['reason'],
      userId: json['user'],
    );
  }
}

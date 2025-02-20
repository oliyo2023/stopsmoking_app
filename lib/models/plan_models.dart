class PlanStage {
  final String name;
  final int durationDays;
  final List<String> tasks;

  PlanStage({
    required this.name,
    required this.durationDays,
    required this.tasks,
  });
}

class PlanProgress {
  PlanStage? currentStage;
  DateTime? startDate;
  Map<DateTime, bool> dailyCheckIn;
  List<SymptomRecord> symptomRecords;

  PlanProgress({
    this.currentStage,
    this.startDate,
    this.dailyCheckIn = const {},
    this.symptomRecords = const [],
  });
}

class SymptomRecord {
  final DateTime dateTime;
  final String symptom;
  final String copingStrategy;

  SymptomRecord({
    required this.dateTime,
    required this.symptom,
    required this.copingStrategy,
  });
}

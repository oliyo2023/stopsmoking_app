class PlanStage {
  String name;
  int durationDays;
  List<String> tasks;

  PlanStage({
    required this.name,
    required this.durationDays,
    required this.tasks,
  });
}

class PlanProgress {
  PlanStage stage;
  DateTime startDate;
  Map<DateTime, bool> dailyCheckIn;
  List<SymptomRecord> symptomRecords;

  PlanProgress({
    required this.stage,
    required this.startDate,
    required this.dailyCheckIn,
    required this.symptomRecords,
  });
}

class SymptomRecord {
  DateTime dateTime;
  String symptom;
  String copingStrategy;

  SymptomRecord({
    required this.dateTime,
    required this.symptom,
    required this.copingStrategy,
  });
}

import 'package:flutter/material.dart';
import '../models/plan_models.dart';

class SymptomRecordForm extends StatefulWidget {
  final Function(SymptomRecord) onSubmit;

  const SymptomRecordForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SymptomRecordForm> createState() => _SymptomRecordFormState();
}

class _SymptomRecordFormState extends State<SymptomRecordForm> {
  final _formKey = GlobalKey<FormState>();
  final _symptomController = TextEditingController();
  final _strategyController = TextEditingController();

  @override
  void dispose() {
    _symptomController.dispose();
    _strategyController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final record = SymptomRecord(
        dateTime: DateTime.now(),
        symptom: _symptomController.text,
        copingStrategy: _strategyController.text,
      );
      widget.onSubmit(record);
      _symptomController.clear();
      _strategyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '症状记录 (Symptom Record)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _symptomController,
                decoration: const InputDecoration(
                  labelText: '症状描述 (Symptom Description)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请描述您的症状 (Please describe your symptoms)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _strategyController,
                decoration: const InputDecoration(
                  labelText: '应对策略 (Coping Strategy)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请描述您的应对策略 (Please describe your coping strategy)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('提交记录 (Submit Record)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
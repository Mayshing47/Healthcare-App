import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/data/models/symptom_to_disease_input.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_button.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_drop_down.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../utils/utils.dart';
import '../providers/disease_detector_provider.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});

  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  String result = '';
  final List<String> _firstSymptomOptions = [
    'Fever',
    'Headache',
    'Chest Pain',
    'Fatigue',
    'Sneezing',
    'High Fever',
    'Loss of Taste',
    'Shortness of Breath',
    'Joint Pain',
    'No Symptoms',
  ];

  final List<String> _secondSymptomOptions = [
    'Cough',
    'Nausea',
    'Sweating',
    'Body Ache',
    'Runny Nose',
    'Chills',
    'Sore Throat'
        'Chest Tightness',
    'Swelling',
    'No Symptoms',
  ];

  final List<String> _thirdSymptomOptions = [
    'Fatigue',
    'Dizziness',
    'Anxiety',
    'Headache',
    'Sore Throat',
    'Body Pain',
    'Difficulty Swallowing',
    'Rapid Heartbeat',
    'Redness',
    'No Symptoms',
  ];
  String _selectedFirstSymptom = 'No Symptoms';
  String _selectedSecondSymptom = 'No Symptoms';
  String _selectedThirdSymptom = 'No Symptoms';

  Future<void> _onPredictTap() async {
    final symptomToDiseaseInput = SymptomToDiseaseInput(
      firstSymptom: _selectedFirstSymptom,
      secondSymptom: _selectedSecondSymptom,
      thirdSymptom: _selectedThirdSymptom,
    );

    await _getResult(symptomToDiseaseInput);
    await _showDialogBox();

  }

  Future<void> _showDialogBox() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Prediction Result"),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _getResult(SymptomToDiseaseInput inputData) async {
    final diseaseProvider = Provider.of<DiseaseDetectorProvider>(context, listen: false);
    Utils.showCircularProgressIndicator(context);
    final predictedHeartDisease = await diseaseProvider.predictDiseaseFromSymptoms(inputData);
    navigatorKey.currentState!.pop();
    setState(() {
      result = predictedHeartDisease;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CustomDropDown(
            options: _firstSymptomOptions,
            label: 'Symptom One',
            selectedValue: _selectedFirstSymptom,
            onChanged: (value) => setState(() => _selectedFirstSymptom = value!),
          ),
          const SizedBox(height: 16),
          CustomDropDown(
            options: _secondSymptomOptions,
            label: 'Symptom Two',
            selectedValue: _selectedSecondSymptom,
            onChanged: (value) => setState(() => _selectedSecondSymptom = value!),

          ),
          const SizedBox(height: 16),
          CustomDropDown(
            options: _thirdSymptomOptions,
            label: 'Symptom Three',
            selectedValue: _selectedThirdSymptom,
            onChanged: (value) => setState(() => _selectedThirdSymptom = value!),

          ),
          const SizedBox(height: 16),
          CustomButton(label: 'Predict Disease', submitData: _onPredictTap),
        ],
      ),
    );
  }
}

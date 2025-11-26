import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/data/models/diabetes_input.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_button.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_text_field.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../providers/disease_detector_provider.dart';

class DiabetesScreen extends StatefulWidget {
  const DiabetesScreen({super.key});

  @override
  State<DiabetesScreen> createState() => _DiabetesScreenState();
}

class _DiabetesScreenState extends State<DiabetesScreen> {
  String result = '';
  final TextEditingController _pregnanciesController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _skinThicknessController = TextEditingController();
  final TextEditingController _insulinController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _diabetesPedigreeFunctionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  Future<void> _predict() async {
    final input = DiabetesInput(
      pregnancies: int.tryParse(_pregnanciesController.text) ?? 0,
      glucose: double.tryParse(_glucoseController.text) ?? 0.0,
      bloodPressure: double.tryParse(_bloodPressureController.text) ?? 0.0,
      skinThickness: double.tryParse(_skinThicknessController.text) ?? 0.0,
      insulin: double.tryParse(_insulinController.text) ?? 0.0,
      bmi: double.tryParse(_bmiController.text) ?? 0.0,
      diabetesPedigreeFunction: double.tryParse(
          _diabetesPedigreeFunctionController.text) ?? 0.0,
      age: int.tryParse(_ageController.text) ?? 0,
    );

    if (_pregnanciesController.text.isEmpty ||
        _glucoseController.text.isEmpty ||
        _bloodPressureController.text.isEmpty ||
        _skinThicknessController.text.isEmpty ||
        _insulinController.text.isEmpty || _bmiController.text.isEmpty ||
        _diabetesPedigreeFunctionController.text.isEmpty ||
        _ageController.text.isEmpty) {
      Utils.showSnackBar('Please fill all the fields');
      return;
    }

    await _getResult(input);
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

  Future<void> _getResult(DiabetesInput inputData) async {
    final diseaseProvider = Provider.of<DiseaseDetectorProvider>(context, listen: false);
    Utils.showCircularProgressIndicator(context);
    final predictedHeartDisease = await diseaseProvider.predictDiabetesDiseases(inputData);
    navigatorKey.currentState!.pop();
    setState(() {
      result = predictedHeartDisease;
    });
    print(result);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Predictor'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CustomTextField(
            label: 'Pregnancies', controller: _pregnanciesController,),
          CustomTextField(label: 'Glucose', controller: _glucoseController,),
          CustomTextField(
            label: 'Blood Pressure', controller: _bloodPressureController,),
          CustomTextField(
            label: 'Skin Thickness', controller: _skinThicknessController,),
          CustomTextField(label: 'Insulin', controller: _insulinController,),
          CustomTextField(label: 'BMI', controller: _bmiController,),
          CustomTextField(label: 'Diabetes Pedigree Function',
            controller: _diabetesPedigreeFunctionController,),
          CustomTextField(label: 'Age', controller: _ageController,),
          CustomButton(label: 'Predict Diabetes', submitData: _predict,)
        ],
      ),
    );
  }
}


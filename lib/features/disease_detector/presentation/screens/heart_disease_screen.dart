import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_button.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_drop_down.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_switch_tile.dart';
import 'package:health_care_application/main.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../data/models/heart_disease_input.dart';
import '../providers/disease_detector_provider.dart';

class HeartDiseaseScreen extends StatefulWidget {
  const HeartDiseaseScreen({super.key});

  @override
  _HeartDiseaseScreenState createState() => _HeartDiseaseScreenState();
}

class _HeartDiseaseScreenState extends State<HeartDiseaseScreen> {
  final TextEditingController physicalHealthController =
      TextEditingController();
  final TextEditingController mentalHealthController = TextEditingController();
  final TextEditingController sleepTimeController = TextEditingController();

  String result = "";

  String selectedBMICategory = "Obese";
  String selectedSex = "Male";
  String selectedAgeCategory = "80 or older";
  String selectedRace = "White";
  String selectedGenHealth = "Very Poor";
  bool smoking = false;
  bool alcoholDrinking = false;
  bool stroke = false;
  bool diffWalking = false;
  bool diabetic = false;
  bool physicalActivity = false;
  bool asthma = false;
  bool kidneyDisease = false;
  bool skinCancer = false;

  void submitData() async {
    HeartDiseaseInput inputData = HeartDiseaseInput(
      bmiCategory: selectedBMICategory,
      smoking: smoking ? "Yes" : "No",
      alcoholDrinking: alcoholDrinking ? "Yes" : "No",
      stroke: stroke ? "Yes" : "No",
      physicalHealth: int.tryParse(physicalHealthController.text) ?? 0,
      mentalHealth: int.tryParse(mentalHealthController.text) ?? 0,
      diffWalking: diffWalking ? "Yes" : "No",
      sex: selectedSex,
      ageCategory: selectedAgeCategory,
      race: selectedRace,
      diabetic: diabetic ? 'Yes' : 'No',
      physicalActivity: physicalActivity ? 'Yes' : 'No',
      genHealth: selectedGenHealth,
      sleepTime: int.tryParse(sleepTimeController.text) ?? 0,
      asthma: asthma ? 'Yes' : 'No',
      kidneyDisease: kidneyDisease ? 'Yes' : 'No',
      skinCancer: skinCancer ? 'Yes' : 'No',
    );

    await _getResult(inputData);
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

  Future<void> _getResult(HeartDiseaseInput inputData) async {
    final diseaseProvider = Provider.of<DiseaseDetectorProvider>(context, listen: false);
    Utils.showCircularProgressIndicator(context);
    final predictedHeartDisease = await diseaseProvider.predictHeartDisease(inputData);
    navigatorKey.currentState!.pop();
    setState(() {
      result = predictedHeartDisease;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Heart Disease Predictor")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBMICategoryComponent(),
            _buildSmokingComponent(),
            _buildAlcoholComponent(),
            _buildStrokeComponent(),
            _buildTextField("Physical Health (Days)", physicalHealthController),
            _buildTextField("Mental Health (Days)", mentalHealthController),
            _buildDifficultyWalkingComponent(),
            _buildSexComponent(),
            _buildAgeCategoryComponent(),
            _buildRaceComponent(),
            _buildDiabetesComponent(),
            _buildPhysicalActivityComponent(),
            // _buildGeneralHealthComponent(),
            _buildTextField("Sleep Time (Hours)", sleepTimeController),
            _buildAsthmaComponent(),
            _buildKidneyDiseaseComponent(),
            _buildSkinCancerComponent(),

            SizedBox(height: 20),
            CustomButton(label: 'Predict Heart Disease', submitData: submitData),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildBMICategoryComponent() {
    return CustomDropDown(
      label: "BMI Category",
      options: ["Underweight", "Normal", "Overweight", "Obese"],
      selectedValue: selectedBMICategory,
      onChanged: (value) {
        setState(() => selectedBMICategory = value!);
      },
    );
  }

  Widget _buildSmokingComponent() {
    return CustomSwitchTile(
      title: "Smoking",
      value: smoking,
      onChanged: (value) => setState(() => smoking = value),
    );
  }

  Widget _buildAlcoholComponent() {
    return CustomSwitchTile(
      title: "Alcohol Drinking",
      value: alcoholDrinking,
      onChanged: (value) => setState(() => alcoholDrinking = value),
    );
  }

  Widget _buildStrokeComponent() {
    return CustomSwitchTile(
      title: "Stroke",
      value: stroke,
      onChanged: (value) => setState(() => stroke = value),
    );
  }

  Widget _buildDifficultyWalkingComponent() {
    return CustomSwitchTile(
      title: "Difficulty Walking",
      value: diffWalking,
      onChanged: (value) => setState(() => diffWalking = value),
    );
  }

  Widget _buildSexComponent() {
    return CustomDropDown(
      label: "Sex",
      options: ["Male", "Female"],
      selectedValue: selectedSex,
      onChanged: (value) => setState(() => selectedSex = value!),
    );
  }

  Widget _buildAgeCategoryComponent() {
    return CustomDropDown(
      label: "Age Category",
      options: [
        "18-24",
        "25-29",
        "30-34",
        "35-39",
        "40-44",
        "45-49",
        "50-54",
        "55-59",
        "60-64",
        "65-69",
        "70-74",
        "75-79",
        "80 or older",
      ],
      selectedValue: selectedAgeCategory,
      onChanged: (value) => setState(() => selectedAgeCategory = value!),
    );
  }

  Widget _buildRaceComponent() {
    return CustomDropDown(
      label: "Race",
      options: ["White", "Black", "Asian", "Hispanic", "Other"],
      selectedValue: selectedRace,
      onChanged: (value) => setState(() => selectedRace = value!),
    );
  }

  Widget _buildDiabetesComponent() {
    return CustomSwitchTile(
      title: "Diabetic",
      value: diabetic,
      onChanged: (value) => setState(() => diabetic = value),
    );
  }

  Widget _buildPhysicalActivityComponent() {
    return CustomSwitchTile(
      title: "Physical Activity",
      value: physicalActivity,
      onChanged: (value) => setState(() => physicalActivity = value),
    );
  }

  Widget _buildGeneralHealthComponent() {
    return CustomSwitchTile(
      title: "General health",
      value: physicalActivity,
      onChanged: (value) => setState(() => physicalActivity = value),
    );
  }

  Widget _buildAsthmaComponent() {
    return CustomSwitchTile(
      title: "Asthma",
      value: asthma,
      onChanged: (value) => setState(() => asthma = value),
    );
  }

  Widget _buildKidneyDiseaseComponent() {
    return CustomSwitchTile(
      title: "Kidney Disease",
      value: kidneyDisease,
      onChanged: (value) => setState(() => kidneyDisease = value),
    );
  }

  Widget _buildSkinCancerComponent() {
    return CustomSwitchTile(
      title: "Skin Cancer",
      value: skinCancer,
      onChanged: (value) => setState(() => skinCancer = value),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/data/models/neurological_disease_input.dart';
import 'package:health_care_application/features/disease_detector/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../utils/utils.dart';
import '../../../disease_detector/presentation/widgets/custom_button.dart';
import '../providers/disease_detector_provider.dart';

class NeurologicalScreen extends StatefulWidget {
  const NeurologicalScreen({super.key});

  @override
  State<NeurologicalScreen> createState() => _NeurologicalScreenState();
}

class _NeurologicalScreenState extends State<NeurologicalScreen> {
  String result = "";
  final TextEditingController _meanAmplitudeController =
      TextEditingController();
  final TextEditingController _peakToPeakController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _entropyController = TextEditingController();
  final TextEditingController _deltaPowerController = TextEditingController();
  final TextEditingController _thetaPowerController = TextEditingController();
  final TextEditingController _alphaPowerController = TextEditingController();
  final TextEditingController _betaPowerController = TextEditingController();
  final TextEditingController _gammaPowerController = TextEditingController();

  void _onPredictPressed() async {
    final NeurologicalDiseaseInput inputData = NeurologicalDiseaseInput(
      meanAmplitude: double.tryParse(_meanAmplitudeController.text) ?? 0.0,
      peakToPeak: double.tryParse(_peakToPeakController.text) ?? 0.0,
      psd: double.tryParse(_psdController.text) ?? 0.0,
      entropy: double.tryParse(_entropyController.text) ?? 0.0,
      deltaPower: double.tryParse(_deltaPowerController.text) ?? 0.0,
      thetaPower: double.tryParse(_thetaPowerController.text) ?? 0.0,
      alphaPower: double.tryParse(_alphaPowerController.text) ?? 0.0,
      betaPower: double.tryParse(_betaPowerController.text) ?? 0.0,
      gammaPower: double.tryParse(_gammaPowerController.text) ?? 0.0,
    );

    if(_meanAmplitudeController.text.trim().isEmpty ||
    _peakToPeakController.text.trim().isEmpty ||
    _psdController.text.trim().isEmpty ||
    _entropyController.text.trim().isEmpty ||
    _deltaPowerController.text.trim().isEmpty ||
    _thetaPowerController.text.trim().isEmpty ||
    _alphaPowerController.text.trim().isEmpty ||
    _betaPowerController.text.trim().isEmpty ||
    _gammaPowerController.text.trim().isEmpty
    )  {
      Utils.showSnackBar("Please fill all the fields");
      return;
    }
    await _getResult(inputData);
    await _showDialogBox();
  }

  Future<void> _getResult(NeurologicalDiseaseInput inputData) async {
    final diseaseProvider = Provider.of<DiseaseDetectorProvider>(
      context,
      listen: false,
    );
    Utils.showCircularProgressIndicator(context);
    final predictedHeartDisease = await diseaseProvider
        .predictNeurologicalDiseases(inputData);
    navigatorKey.currentState!.pop();
    setState(() {
      result = predictedHeartDisease;
    });
    print(result);
  }

  Future<void> _showDialogBox() async {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neurological Disease Predictor')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              label: 'Mean Amplitude',
              controller: _meanAmplitudeController,
            ),
            CustomTextField(
              label: 'Peak to Peak',
              controller: _peakToPeakController,
            ),
            CustomTextField(label: 'PSD', controller: _psdController),
            CustomTextField(label: 'Entropy', controller: _entropyController),
            CustomTextField(
              label: 'Delta Power',
              controller: _deltaPowerController,
            ),
            CustomTextField(
              label: 'Theta Power',
              controller: _thetaPowerController,
            ),
            CustomTextField(
              label: 'Alpha Power',
              controller: _alphaPowerController,
            ),
            CustomTextField(
              label: 'Beta Power',
              controller: _betaPowerController,
            ),
            CustomTextField(
              label: 'Gamma Power',
              controller: _gammaPowerController,
            ),
            SizedBox(height: 20),
            CustomButton(label: 'Predict Neurological Disease', submitData: _onPredictPressed),
          ],
        ),
      ),
    );
  }
}

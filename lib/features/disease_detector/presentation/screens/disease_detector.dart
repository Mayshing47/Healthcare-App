import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/presentation/screens/symptom_screen.dart';
import 'diabetes_screen.dart';
import 'heart_disease_screen.dart';
import 'neurological_screen.dart';

class DiseaseDetectorScreen extends StatefulWidget {
  const DiseaseDetectorScreen({super.key});

  @override
  State<DiseaseDetectorScreen> createState() => _DiseaseDetectorScreenState();
}

class _DiseaseDetectorScreenState extends State<DiseaseDetectorScreen> {
  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          children: [
            _buildCard(context, "Neurological Predictor", "assets/images/neurology.png", NeurologicalScreen()),
            _buildCard(context, "Diabetes Predictor", "assets/images/diabetes.png", DiabetesScreen()),
            _buildCard(context, "Heart Disease Predictor", "assets/images/heart.png", HeartDiseaseScreen()),
            _buildCard(context, "Symptom-to-Disease", "assets/images/symptom.png", SymptomScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String imagePath, Widget screen) {
    return GestureDetector(
      onTap: () => navigateTo(context, screen),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.3),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 60),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

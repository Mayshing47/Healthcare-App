

import 'package:health_care_application/features/disease_detector/data/models/diabetes_input.dart';

abstract class DiabetesDiseaseRepository {

  Future<String> predictDiabetes(DiabetesInput input);
}
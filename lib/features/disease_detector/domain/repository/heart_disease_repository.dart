

import '../../data/models/heart_disease_input.dart';

abstract class HeartDiseaseRepository {
  Future<String> predictHeartDisease(HeartDiseaseInput inputData);
}
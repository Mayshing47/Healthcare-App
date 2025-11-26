import 'package:flutter/material.dart';
import 'package:health_care_application/features/disease_detector/data/models/diabetes_input.dart';
import 'package:health_care_application/features/disease_detector/domain/repository/diabetes_disease_repository.dart';
import '../../data/models/heart_disease_input.dart';
import '../../data/models/neurological_disease_input.dart';
import '../../data/models/symptom_to_disease_input.dart';
import '../../domain/repository/heart_disease_repository.dart';
import '../../domain/repository/neurological_disease_repository.dart';
import '../../domain/repository/symptom_to_disease_repository.dart';

class DiseaseDetectorProvider extends ChangeNotifier {
  final HeartDiseaseRepository _heartDiseaseRepository;
  final NeurologicalDiseaseRepository _neurologicalDiseaseRepository;
  final DiabetesDiseaseRepository _diabetesDiseaseRepository;
  final SymptomToDiseaseRepository _symptomToDiseaseRepository;

  DiseaseDetectorProvider({
    required HeartDiseaseRepository heartDiseaseRepository,
    required NeurologicalDiseaseRepository neurologicalDiseaseRepository,
    required DiabetesDiseaseRepository diabetesDiseaseRepository,
    required SymptomToDiseaseRepository symptomToDiseaseRepository,
  }) : _heartDiseaseRepository = heartDiseaseRepository,
       _neurologicalDiseaseRepository = neurologicalDiseaseRepository,
       _diabetesDiseaseRepository = diabetesDiseaseRepository,
       _symptomToDiseaseRepository = symptomToDiseaseRepository;

  Future<String> predictHeartDisease(HeartDiseaseInput inputData) async {
    try {
      return await _heartDiseaseRepository.predictHeartDisease(inputData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> predictNeurologicalDiseases(
    NeurologicalDiseaseInput inputData,
  ) async {
    try {
      return await _neurologicalDiseaseRepository.getNeurologicalDiseases(
        inputData,
      );
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> predictDiabetesDiseases(DiabetesInput inputData) async {
    try {
      return await _diabetesDiseaseRepository.predictDiabetes(inputData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> predictDiseaseFromSymptoms(
    SymptomToDiseaseInput inputData,
  ) async =>
      await _symptomToDiseaseRepository.predictDiseaseFromSymptoms(inputData);
}

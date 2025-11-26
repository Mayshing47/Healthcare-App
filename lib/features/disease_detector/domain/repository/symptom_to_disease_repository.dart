

import '../../data/models/symptom_to_disease_input.dart';

abstract class SymptomToDiseaseRepository {
  Future<String> predictDiseaseFromSymptoms(SymptomToDiseaseInput input);

}
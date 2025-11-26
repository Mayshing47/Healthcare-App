

import '../../data/models/neurological_disease_input.dart';

abstract class NeurologicalDiseaseRepository {

  Future<String> getNeurologicalDiseases(NeurologicalDiseaseInput inputData);
}
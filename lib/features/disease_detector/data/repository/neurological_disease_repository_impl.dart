import '../../domain/repository/neurological_disease_repository.dart';
import '../data_source/remote/neurological_disease_data_source.dart';
import '../models/neurological_disease_input.dart';

class NeurologicalDiseaseRepositoryImpl extends NeurologicalDiseaseRepository {
  final NeurologicalDiseaseDataSource _neurologicalDiseaseDataSource;

  NeurologicalDiseaseRepositoryImpl({
    required NeurologicalDiseaseDataSource neurologicalDiseaseDataSource,
  }) : _neurologicalDiseaseDataSource = neurologicalDiseaseDataSource;

  @override
  Future<String> getNeurologicalDiseases(NeurologicalDiseaseInput inputData) async {
    try {
      return await _neurologicalDiseaseDataSource.getNeurologicalDiseases(inputData);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

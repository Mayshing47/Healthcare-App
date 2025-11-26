
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/symptom_to_disease_input.dart';

class SymptomToDiseaseRemoteDataSource {

  final String apiUrl = 'https://human-input.onrender.com/predict';

  Future<String> predictDiseaseFromSymptoms(SymptomToDiseaseInput input) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(input.toJson()),
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['predicted_disease'];
      } else {
        throw Exception('Failed to predict disease');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
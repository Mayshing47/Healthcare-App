import 'dart:convert';

import 'package:health_care_application/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../models/neurological_disease_input.dart';

class NeurologicalDiseaseDataSource {

  final apiUrl = 'https://egg-hiui.onrender.com/predict';

  Future<String> getNeurologicalDiseases(NeurologicalDiseaseInput inputData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(inputData.toJson()),
      );

      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['prediction'];
      } else {
        throw Exception('Failed to predict neurological disease');
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
      throw Exception('Error: $e');
    }
  }

}
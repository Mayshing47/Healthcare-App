import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:health_care_application/constants/string_constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/utils.dart';


class PickedImageProvider extends ChangeNotifier {

  File? _selectedImage;
  String _recognizedText = "";
  String _recognizedTextSummary = "";

  File? get selectedImage => _selectedImage;
  String get recognizedText => _recognizedText;
  String get recognizedTextSummary => _recognizedTextSummary;



  final _imagePicker = ImagePicker();
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<void> selectImageFromGallery() async {
    try {
      final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(pickedImage != null) {
        _selectedImage = File(pickedImage.path);
        await performOCR(pickedImage.path);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Utils.showSnackBar(e.toString());
    }
  }

  Future<void> selectImageFromCamera() async {
    try {
      final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
      if(pickedImage != null) {
        _selectedImage = File(pickedImage.path);
        await performOCR(pickedImage.path);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Utils.showSnackBar(e.toString());
    }
  }

  Future<void> performOCR(String imagePath) async {
    try {
      // Create an InputImage from the file path
      final inputImage = InputImage.fromFilePath(imagePath);

      // Process the image to recognize text
      final recognizedText = await _textRecognizer.processImage(inputImage);

      // Get the recognized text
      String extractedText = recognizedText.text;

      // Update the recognizedText in the provider
      _recognizedText = extractedText;

      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('OCR Error: ${e.toString()}');
      }
      Utils.showSnackBar('Error performing OCR: ${e.toString()}');
    }
  }


  Future<void> getSummary() async {
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: geminiAPIKey);
      final content = Content.text('$_recognizedText make the summary of this text');
      final response = await model.generateContent([content]);
      _recognizedTextSummary = response.text!;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to send message: $e');
      }
      _recognizedTextSummary = 'Error: $e';
      notifyListeners();
    }
  }


  @override
  void dispose() {
    super.dispose();
    _textRecognizer.close();
  }
}
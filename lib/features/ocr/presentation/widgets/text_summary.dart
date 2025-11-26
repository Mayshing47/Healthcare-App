import 'package:flutter/material.dart';
import 'package:health_care_application/features/ocr/presentation/providers/picked_image_provider.dart';
import 'package:provider/provider.dart';

class TextSummary extends StatefulWidget {
  const TextSummary({super.key});

  @override
  State<TextSummary> createState() => _TextSummaryState();
}

class _TextSummaryState extends State<TextSummary> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickedImageProvider>(
      builder: (context, pickedImageProvider, child) =>
          SizedBox(
            child: Text(pickedImageProvider.recognizedTextSummary),
          ),
    );
  }
}
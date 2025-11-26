import 'package:flutter/material.dart';
import 'package:health_care_application/features/ocr/presentation/providers/picked_image_provider.dart';
import 'package:health_care_application/features/ocr/presentation/widgets/text_summary.dart';
import 'package:provider/provider.dart';

class ExtractedTextScreen extends StatefulWidget {
  const ExtractedTextScreen({super.key});

  @override
  State<ExtractedTextScreen> createState() => _ExtractedTextScreenState();
}

class _ExtractedTextScreenState extends State<ExtractedTextScreen> {

  void _onFloatingActionButtonTap() async {
    final pickedImageProvider = Provider.of<PickedImageProvider>(context, listen: false);
    await pickedImageProvider.getSummary();
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: TextSummary(),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      appBar: AppBar(
        title: Text('Extracted Text'),
        backgroundColor: Colors.blueAccent, // Can be customized
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recognized Text:',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Consumer<PickedImageProvider>(
                builder: (context, pickedImageProvider, child) {
                  final recognizedText = pickedImageProvider.recognizedText;

                  return recognizedText.isEmpty
                      ? Center(
                    child: Text(
                      'No text recognized. Please try again.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          recognizedText,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
          onPressed: _onFloatingActionButtonTap, child: Text('SEE SUMMARY',textAlign: TextAlign.center,)),
    );
  }
}

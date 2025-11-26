import 'package:flutter/material.dart';
import 'package:health_care_application/features/ocr/presentation/providers/picked_image_provider.dart';
import 'package:health_care_application/features/ocr/presentation/screens/extracted_text_screen.dart';
import 'package:health_care_application/features/ocr/presentation/widgets/image_picking_dialog.dart';
import 'package:health_care_application/utils/utils.dart';
import 'package:provider/provider.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  void _onFloatingActionButtonTap() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(content: ImagePickingDialog());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImageComponent(),
              const SizedBox(height: 20),
              _buildNavigateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageComponent() {
    final screenWidth = Utils.getScreenWidth(context);
    final screenHeight = Utils.getScreenHeight(context);
    return Consumer<PickedImageProvider>(
      builder: (context, imageProvider, child) {
        final selectedImage = imageProvider.selectedImage;
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: screenWidth * 0.9,
          height: screenHeight * 0.7,
          child:
              selectedImage != null
                  ? Image.file(selectedImage)
                  : Text(
                    'Select an Image',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
        );
      },
    );
  }

  Widget _buildNavigateButton() {
    return ElevatedButton(onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExtractedTextScreen()));
    }, child: Text('See extracted text'));
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _onFloatingActionButtonTap,
      child: Text('+', style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

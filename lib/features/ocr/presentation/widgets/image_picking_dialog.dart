import 'package:flutter/material.dart';
import 'package:health_care_application/features/ocr/presentation/providers/picked_image_provider.dart';
import 'package:health_care_application/main.dart';
import 'package:provider/provider.dart';

class ImagePickingDialog extends StatefulWidget {
  const ImagePickingDialog({super.key});

  @override
  State<ImagePickingDialog> createState() => _ImagePickingDialogState();
}

class _ImagePickingDialogState extends State<ImagePickingDialog> {

  void _onGalleryImagePickingTap() async {
    final imageProvider = Provider.of<PickedImageProvider>(context, listen: false);
    await imageProvider.selectImageFromGallery();
    navigatorKey.currentState!.pop();
  }

  void _onCameraImagePickingTap() async {
    final imageProvider = Provider.of<PickedImageProvider>(context, listen: false);
    await imageProvider.selectImageFromCamera();
    navigatorKey.currentState!.pop();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGalleryImagePickingButton(),
          _buildCameraImagePickingButton(),
        ],
      ),
    );
  }

  Widget _buildGalleryImagePickingButton() {
    return ListTile(
      leading: Icon(Icons.image),
      title: Text('Pick from Gallery'),
      onTap: _onGalleryImagePickingTap,
    );
  }

  Widget _buildCameraImagePickingButton() {
    return ListTile(
      leading: Icon(Icons.camera_alt),
      title: Text('Take a Photo'),
      onTap: _onCameraImagePickingTap,
    );
    }
}

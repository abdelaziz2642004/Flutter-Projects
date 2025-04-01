import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Userr extends StatefulWidget {
  const Userr({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<Userr> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<Userr> {
  File? _pickedImageFile;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show a dialog to choose between camera and gallery
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final pickedImage = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    maxWidth: 150,
                  );
                  _handleImagePicked(pickedImage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final pickedImage = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 150,
                  );
                  _handleImagePicked(pickedImage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleImagePicked(XFile? pickedImage) {
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(
            Icons.photo_camera,
            size: 20,
            // color: Color.fromARGB(255, 231, 147, 72),
          ),
          label: const Text(
            'Update Image!!',
            style: TextStyle(
              fontSize: 15,
              // color: Color.fromARGB(255, 239, 137, 47),
            ),
          ),
        ),
      ],
    );
  }
}

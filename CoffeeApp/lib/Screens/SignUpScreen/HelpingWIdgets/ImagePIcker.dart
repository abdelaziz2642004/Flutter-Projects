import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prj/Providers/userProvider.dart';

class UserImagePicker extends ConsumerStatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
    required this.fromProfile,
  });
  final bool fromProfile;
  final void Function(File pickedImage) onPickImage;

  @override
  ConsumerState<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends ConsumerState<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
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
    if (pickedImage == null) return;
    setState(() => _pickedImageFile = File(pickedImage.path));
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).value;
    final imageUrl = user?.ImageUrl;

    return GestureDetector(
      onTap: user!.fullName != 'Guest' ? _pickImage : () {},
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: widget.fromProfile ? 50 : 40,
                backgroundColor: const Color(0xffc47c51),
                backgroundImage:
                    _pickedImageFile != null
                        ? FileImage(_pickedImageFile!)
                        : (imageUrl != null && imageUrl.isNotEmpty
                                ? CachedNetworkImageProvider(imageUrl)
                                : const AssetImage('assets/images/profile.jpg'))
                            as ImageProvider,
              ),
              if (user.fullName != 'Guest')
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(194, 0, 0, 0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          if (!widget.fromProfile)
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image, color: Color(0xffc47c51)),
              label: const Text(
                'Update your image',
                style: TextStyle(
                  color: Color(0xffc47c51),
                  fontWeight: FontWeight.bold,
                  fontFamily: "DopisBold",
                ),
              ),
            ),
        ],
      ),
    );
  }
}

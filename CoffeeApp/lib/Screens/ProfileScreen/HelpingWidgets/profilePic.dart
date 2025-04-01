import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/ProfileScreen/cloudinaryService.dart';
import 'package:prj/Screens/SignUpScreen/HelpingWIdgets/ImagePIcker.dart';

class ProfilePicture extends ConsumerStatefulWidget {
  const ProfilePicture({super.key, required this.onUploadStateChanged});
  final void Function(bool) onUploadStateChanged;

  @override
  ConsumerState createState() => _ProfilePictureState();
}

// async stuff , need to prevent the users from exiting in case of is uploading

class _ProfilePictureState extends ConsumerState<ProfilePicture> {
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user currentUser = ref.read(userProvider).value ?? user();
    imageUrl = currentUser.ImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UserImagePicker(
          onPickImage: (image) async {
            widget.onUploadStateChanged(
              true,
            ); //close the navigation back in the profile screen
            await CloudinaryService.pickAndUploadImage(image, ref);
            // after waiting and this is completely done , set it back to false please :D
            widget.onUploadStateChanged(
              false,
            ); //close the navigation back in the profile screen

            //
            // ref.invalidate(userProvider);
          },
          fromProfile: true,
        ),
      ],
    );
  }
}

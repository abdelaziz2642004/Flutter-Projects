import 'package:store_app/ImagePIcker.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/ProfileScreen/ProfileService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/main.dart';

class ProfilePicture extends ConsumerStatefulWidget {
  const ProfilePicture({super.key});

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
    profileService = ProfileService(ref: ref);
    Customer cust = ref.read(customerProviderr);
    profileService.gender = cust.gender;
    profileService.fullName = cust.fullName;
    profileService.level = cust.level;
    profileService.ID = cust.ID;
    profileService.email = cust.email;
  }

  late final ProfileService profileService;

  @override
  Widget build(BuildContext context) {
    ref.watch(customerProviderr);
    return Column(
      children: [
        UserImagePicker(
          onPickImage: (image) async {
            final isConnected = await ProfileService.checkBackendConnection();
            if (!isConnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ Not connected to backend. try again later"),
                ),
              );
              return;
            }
            profileService.uploadImage(image);
          },
          fromProfile: true,
        ),
        TextButton(
          onPressed: () async {
            final isConnected = await ProfileService.checkBackendConnection();
            if (!isConnected) {
              ScaffoldMessenger.of(context).clearSnackBars();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("❌ Not connected to backend. try again later"),
                ),
              );
              return;
            }
            profileService.deleteImage();
          },
          child: const Text(
            'Delete Image',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

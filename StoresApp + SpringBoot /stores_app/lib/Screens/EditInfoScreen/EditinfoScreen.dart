import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/Screens/EditInfoScreen/HelpingWidgets.dart/Edit_fields_section.dart';
import 'package:store_app/Screens/EditInfoScreen/HelpingWidgets.dart/save_button_section.dart';
import 'package:store_app/Screens/EditInfoScreen/editService.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Editinfoscreen extends ConsumerStatefulWidget {
  const Editinfoscreen({super.key});

  @override
  ConsumerState<Editinfoscreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<Editinfoscreen> {
  @override
  void initState() {
    super.initState();
    editservice = EditService(
      rebuildParent: () {
        setState(() {});
      },
      ref: ref,
    );
    Customer customer = ref.read(customerProviderr);

    editservice.fullName = customer.fullName;
    editservice.ID = customer.ID;
    editservice.email = customer.email;
  }

  late EditService editservice;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Edit Your Details",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EditFields(service: editservice),
                  ...SaveButton(editservice, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

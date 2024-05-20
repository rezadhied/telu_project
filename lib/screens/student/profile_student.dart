import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:telu_project/screens/login/welcome_screen.dart';
import 'package:provider/provider.dart';

class ProfileStudent extends StatefulWidget {
  const ProfileStudent({super.key});

  @override
  State<ProfileStudent> createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  bool isEditing = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController nimController;
  late TextEditingController phoneController;
  late TextEditingController genderController;
  late TextEditingController facultyController;
  late TextEditingController majorController;
  String? imagePath = 'assets/images'; // Set default image path

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: 'Jonathan');
    lastNameController = TextEditingController(text: 'Smith');
    nimController = TextEditingController(text: '123456789');
    phoneController = TextEditingController(text: '1234567890');
    genderController = TextEditingController(text: 'Male');
    facultyController = TextEditingController(text: 'Engineering');
    majorController = TextEditingController(text: 'Computer Science');
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.only(top: 1.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black26))),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: isEditing ? _pickImage : null,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isEditing
                                ? Border.all(color: Colors.red, width: 2.0)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage: imagePath != null
                                ? FileImage(File(imagePath!))
                                : AssetImage(imagePath!) as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Jonathan Smith',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Text('j.smith@example.com'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isEditing,
                        child: Row(
                          children: [
                            ElevatedButton(
                              
                              onPressed: () {
                                setState(() {
                                  isEditing = !isEditing;
                                });
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            const SizedBox(width: 24),
                            ElevatedButton(
                                onPressed: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logoutUser();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => WelcomePage()));
                                },
                                child: Text("Logout")),
                          ],
                        ),
                      ),
                      if (isEditing)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Save'),
                            ),
                            const SizedBox(width: 24),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    buildTextFormField('First Name', firstNameController),
                    const SizedBox(height: 16),
                    buildTextFormField('Last Name', lastNameController),
                    const SizedBox(height: 16),
                    buildTextFormField('NIM', nimController),
                    const SizedBox(height: 16),
                    buildTextFormField('No Handphone', phoneController),
                    const SizedBox(height: 16),
                    buildTextFormField('Gender', genderController),
                    const SizedBox(height: 16),
                    buildTextFormField('Faculty', facultyController),
                    const SizedBox(height: 16),
                    buildTextFormField('Major', majorController),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    nimController.dispose();
    phoneController.dispose();
    genderController.dispose();
    facultyController.dispose();
    majorController.dispose();
    super.dispose();
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: isEditing ? Colors.grey : const Color(0xFF002B5B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}

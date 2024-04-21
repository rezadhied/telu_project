import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: isEditing
                    ? _pickImage
                    : null, // Only enable tap for image selection in editing mode
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : AssetImage(imagePath!) as ImageProvider,
                    ),
                    if (isEditing)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2.0),
                        ),
                        width: 124,
                        height: 124,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: !isEditing,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Jonathan Smith',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('j.smith@example.com'),
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
          ),
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
      child: TextFormField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: isEditing ? Colors.grey : Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

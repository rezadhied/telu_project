import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:telu_project/screens/login/welcome_screen.dart';

class ProfileLecturer extends StatefulWidget {
  const ProfileLecturer({super.key});

  @override
  State<ProfileLecturer> createState() => _ProfileLecturerState();
}

class _ProfileLecturerState extends State<ProfileLecturer> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController nimController;
  late TextEditingController phoneController;
  late TextEditingController genderController;
  late TextEditingController facultyController;
  late TextEditingController LecturerCodeController;
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
    LecturerCodeController = TextEditingController(text: 'Computer Science');
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

  Future<Map<String, dynamic>> fetchUserData() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();

    String userId = pref.getString('userId') ?? '';
    print(userId);
    final response = await http.get(Uri.parse('$url/users/$userId'));
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Fetch User Data');
    }
  }

  Future<void> _updateProfile() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();

    String userId = pref.getString('userId') ?? '';

    final response = await http.put(
      Uri.parse('$url/user/$userId'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phoneNumber': phoneController.text,
        'gender': genderController.text,
        'facultyName': facultyController.text,
        'lectureCode': LecturerCodeController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated successfully'),
      ));
      setState(() {
        isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var userdata = snapshot.data!;

              firstNameController.text = userdata['firstName'];
              lastNameController.text = userdata['lastName'];
              nimController.text = userdata['userID'];
              phoneController.text = userdata['phoneNumber'];
              genderController.text = userdata['gender'];
              facultyController.text = userdata['facultyName'];
              LecturerCodeController.text = userdata['lectureCode'];
              return Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black26))),
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
                                        ? Border.all(
                                            color: Colors.red, width: 2.0)
                                        : null,
                                  ),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: imagePath != null
                                        ? FileImage(File(imagePath!))
                                        : AssetImage(imagePath!)
                                            as ImageProvider,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userdata['firstName'],
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WelcomePage()));
                                        },
                                        child: Text("Logout")),
                                  ],
                                ),
                              ),
                              if (isEditing)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _updateProfile();
                                        }
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            const SizedBox(height: 24),
                            buildTextFormField(
                                'First Name', firstNameController),
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
                            buildTextFormField(
                                'Lecturer Code', LecturerCodeController),
                            const SizedBox(height: 16),
                          ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }

          // var userData = snapshot.data!;
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
    LecturerCodeController.dispose();
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

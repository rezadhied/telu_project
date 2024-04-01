import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';

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
  TextEditingController firstNameController =
      TextEditingController(text: 'Jonathan');
  TextEditingController lastNameController =
      TextEditingController(text: 'Smith');
  TextEditingController nimController =
      TextEditingController(text: '123456789');
  TextEditingController phoneController =
      TextEditingController(text: '1234567890');
  TextEditingController genderController = TextEditingController(text: 'Male');
  TextEditingController facultyController =
      TextEditingController(text: 'Engineering');
  TextEditingController majorController =
      TextEditingController(text: 'Computer Science');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/ijad.jpg'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? 'Save' : 'Edit'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Jonathan Smith',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('j.smith@example.com'),
              const SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: firstNameController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: lastNameController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: nimController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: phoneController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'No Handphone',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: genderController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: facultyController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Faculty',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: majorController,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    labelText: 'Major',
                    labelStyle: TextStyle(
                      color: isEditing ? AppColors.grey : Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (isEditing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Simpan perubahan
                        setState(() {
                          isEditing = false;
                        });
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Batalkan perubahan
                        setState(() {
                          isEditing = false;
                        });
                      },
                      child: Text('Cancel'),
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
}

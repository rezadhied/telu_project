import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:telu_project/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/screens/student/home_student.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({Key? key}) : super(key: key);

  @override
  _JoinProjectState createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {
  String? selectedRole;
  String? selectedFileName;
  PlatformFile? selectedFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.name != null) {
      setState(() {
        selectedFile = result.files.single;
        selectedFileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
      setState(() {
        selectedFile = null;
        selectedFileName = null;
      });
    }
  }

  Future<void> submitForm() async {
    if (nameController.text.isEmpty ||
        selectedRole == null ||
        messageController.text.isEmpty ||
        selectedFile == null) {
      // Show an error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields and select a file.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Upload the file
    String fileName = selectedFile!.name;
    String url = '/'; //

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['userID'] = '1'  // user id nya mana
      ..fields['projectID'] = '1'
      ..fields['roleID'] = selectedRole!
      ..fields['message'] = messageController.text
      ..files.add(await http.MultipartFile.fromPath('cv', selectedFile!.path!));

    var response = await request.send();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => const MainApp(
                selectedIndex: 1,
              )),
      (route) => false,
    );
    if (response.statusCode != 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to submit the form.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(254, 251, 246, 1),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Project',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Project Title',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            color: AppColors.blackAlternative,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeStudent()),
                        );
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'x',
                            style: GoogleFonts.inter(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Student Name',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: AppColors.blackAlternative,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Select Your Role',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: AppColors.blackAlternative,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRole,
                      hint: Text('Select role'),
                      isExpanded: true,
                      items: <String>[
                        'Back-End Developer',
                        'Front-End Developer',
                        'UI/UX Designer',
                        'Data Scientist',
                        'Data Analyst',
                        'Business Analyst',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRole = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Tell us about yourself and why you want to join this project',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: AppColors.blackAlternative,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: messageController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Write Your Reason',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Upload Supporting Document',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: AppColors.blackAlternative,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: pickFile,
                  child: Text(selectedFileName ?? 'Choose File'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: submitForm,
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

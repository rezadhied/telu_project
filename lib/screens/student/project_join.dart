import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telu_project/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/screens/student/home_student.dart';
import 'package:provider/provider.dart';

class JoinProject extends StatefulWidget {
  final Map<String, dynamic> projectData;
  const JoinProject({Key? key, required this.projectData}) : super(key: key);

  @override
  _JoinProjectState createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {
  String? selectedRole;
  String? selectedFileName;
  PlatformFile? selectedFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController =
      TextEditingController(text: 'saya ingin bergabung');

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
    if (selectedRole == null || messageController.text.isEmpty) {
      if (selectedRole == null) {
        Fluttertoast.showToast(
            msg: "Please select a role",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Please fill all the fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            fontSize: 16.0);
      }
      return;
    }

    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    var userID = SharedPreferencesHelper().getString('userId');

    var projectID = widget.projectData['projectID'];
    var roleID = selectedRole;
    var message = messageController.text;
    var cv = selectedFile;

    print(userID.toString() +
        " " +
        widget.projectData['projectID'].toString() +
        " " +
        selectedRole.toString());
    print(messageController.text);
    print(selectedFile);

    var response = await http.post(
      Uri.parse("$url/createRequest"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'userID': userID,
        'projectID': projectID,
        'roleID': roleID,
        'message': message,
        'cv': cv,
      }),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => const MainApp(
                selectedIndex: 1,
              )),
      (route) => false,
    );

    if (response.statusCode != 201) {
      var responseBody = jsonDecode(response.body);
      String errorMessage = responseBody['msg'] ?? 'An error occurred';
      print(errorMessage);
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Successfully request join to project!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.black,
          textColor: AppColors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
                            widget.projectData['title'],
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
                          Navigator.pop(context);
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
                        items: (widget.projectData['ProjectRoles']
                                as List<dynamic>)
                            .map((role) {
                          var roleMap = role as Map<String, dynamic>;
                          return DropdownMenuItem<String>(
                            value: roleMap['roleID'].toString(),
                            child: Text(roleMap['Role']['name'] as String),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRole = newValue;
                            print(selectedRole);
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
                    onChanged: (value) => setState(() {}),
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
                      backgroundColor: AppColors.secondary,
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
                        backgroundColor: selectedRole == null ||
                                messageController.text.isEmpty
                            ? AppColors.grey
                            : AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

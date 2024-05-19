import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:telu_project/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/screens/home_screen.dart';

class JoinProject extends StatefulWidget {
  const JoinProject({Key? key}) : super(key: key);

  @override
  _JoinProjectState createState() => _JoinProjectState();
}

class _JoinProjectState extends State<JoinProject> {
  String? selectedRole;
  String? selectedFileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.name != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
      setState(() {
        selectedFileName = null;
      });
    }
  }

  void submitForm() {
    // Add any form validation or submission logic here

    // Navigate to the homepage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color.fromRGBO(254, 251, 246, 1),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Row(
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
                        SizedBox(height: 4), // Add some space between the texts
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
                          MaterialPageRoute(builder: (context) => HomePage()),
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
              ),
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 16), // Add some space before the text field
                    Text(
                      'Student Name',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: AppColors.blackAlternative,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8), // Add some space before the text box
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth > 400
                              ? 400
                              : constraints.maxWidth - 60,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Enter your name',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 210,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 16), // Add some space before the text field
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
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth > 400
                              ? 400
                              : constraints.maxWidth - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRole,
                              hint: Text('Select role'),
                              isExpanded: false,
                              items: <String>[
                                'Manager',
                                'QA',
                                'Backend',
                                'Frontend'
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
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 320,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 16), // Add some space before the text field
                    Text(
                      'Tell us about yourself and why you want to join this project',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: AppColors.blackAlternative,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8), // Add some space before the text box
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth > 400
                              ? 400
                              : constraints.maxWidth - 50,
                          height: 200,
                          child: TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: 'Write Your Reason',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 460,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 16), // Add some space before the text field
                    Text(
                      'Upload Supporting Document',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: AppColors.blackAlternative,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8), // Add some space before the text box
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth > 400
                              ? 400
                              : constraints.maxWidth - 20,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: pickFile,
                            child: Text(selectedFileName ?? 'Choose File'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor:
                                  AppColors.primary, // background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 570,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16), // Add some space before the button
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.white,
                        backgroundColor: AppColors.primary, // background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

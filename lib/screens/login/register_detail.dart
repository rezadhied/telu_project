import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/components/button_component.dart';
import 'package:telu_project/components/dropdown_component.dart';
import 'package:telu_project/components/text_field_component.dart';
import 'package:telu_project/screens/login/signin.dart';
import 'package:telu_project/screens/student/my_project_student.dart';
import 'package:telu_project/screens/main_app.dart';

class RegisterDetail extends StatefulWidget {
  final String email;
  final String password;
  final List<dynamic> dataFacultyMajor;
  final bool isStudent;

  const RegisterDetail(
      {super.key,
      required this.email,
      required this.password,
      required this.dataFacultyMajor,
      required this.isStudent});

  @override
  State<RegisterDetail> createState() => _RegisterDetailState();
}

class _RegisterDetailState extends State<RegisterDetail> {
  late List<dynamic> dataFacultyMajor;
  List<String> dataMajor = [];
  List<String> dataClass = [];

  String? selectedFaculty;
  String? selectedMajor;
  String? selectedGender;
  String? selectedYear;
  String? selectedClass;

  String? name;
  String? phoneNumber;
  String? facultyId;
  String? majorId;
  String? lecturerCode;

  String? registerErrorMessage;

  @override
  void initState() {
    super.initState();
    dataFacultyMajor = widget.dataFacultyMajor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 50),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start the journey.",
                    style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackAlternative),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text("Fill your personal info",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                        )),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 450, // Set your desired max height here
                    ),
                    child: Scrollbar(
                      thickness: 1,
                      radius: Radius.circular(3),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFieldComponent(
                              hintText: "Name",
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                            DropdownComponent(
                              hintText: "Gender",
                              subMenu: ["Male", "Female"],
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              selectedItem: selectedGender,
                            ),
                            TextFieldComponent(
                                hintText: "Phone Number",
                                onChanged: (value) {
                                  setState(() {
                                    phoneNumber = value;
                                  });
                                }),
                            !widget.isStudent
                                ? TextFieldComponent(
                                    hintText: "Lecturer Code",
                                    onChanged: (value) {
                                      setState(() {
                                        lecturerCode = value;
                                      });
                                    })
                                : const SizedBox(),
                            widget.isStudent
                                ? DropdownComponent(
                                    hintText: "Academic Year",
                                    subMenu: const [
                                      "2017",
                                      "2018",
                                      "2019",
                                      "2020",
                                      "2021",
                                      "2022",
                                      "2023",
                                      "2024"
                                    ],
                                    selectedItem: selectedYear,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedYear = value;
                                        if (selectedMajor != null) {
                                          dataClass = ["01", "02", "03", "04"]
                                              .map((el) => [
                                                    majorId!,
                                                    selectedYear!.substring(2),
                                                    el
                                                  ].join("-"))
                                              .toList();
                                        }
                                      });
                                    },
                                  )
                                : const SizedBox(),
                            DropdownComponent(
                              hintText: "Faculty",
                              subMenu: dataFacultyMajor
                                  .map((faculty) => faculty['name'] as String)
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedFaculty = value;
                                  dataMajor = dataFacultyMajor
                                      .firstWhere((faculty) =>
                                          faculty['name'] == value)['Majors']
                                      .map<String>(
                                          (major) => major['name'] as String)
                                      .toList();
                                  facultyId = dataFacultyMajor.firstWhere(
                                      (faculty) =>
                                          faculty['name'] == value)['code'];
                                  dataClass = [];
                                  selectedMajor = null;
                                  selectedClass = null;
                                });
                              },
                              selectedItem: selectedFaculty,
                            ),
                            widget.isStudent
                                ? DropdownComponent(
                                    hintText: "Major",
                                    subMenu: dataMajor,
                                    selectedItem: selectedMajor,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedMajor = value;
                                        majorId = dataFacultyMajor
                                            .firstWhere((faculty) =>
                                                faculty['name'] ==
                                                selectedFaculty)['Majors']
                                            .firstWhere((major) =>
                                                major['name'] == value)['code'];
                                        if (selectedYear != null) {
                                          dataClass = ["01", "02", "03", "04"]
                                              .map((el) => [
                                                    majorId!,
                                                    selectedYear!.substring(2),
                                                    el
                                                  ].join("-"))
                                              .toList();
                                        }
                                      });
                                    },
                                  )
                                : const SizedBox(),
                            widget.isStudent
                                ? DropdownComponent(
                                    hintText: "Class",
                                    subMenu: dataClass,
                                    selectedItem: selectedClass,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedClass = value;
                                      });
                                    },
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonComponent(
                    buttonText: "Sign Up",
                    targetPage: const MainApp(),
                    isReplacementPush: true,
                    action: "reg-2",
                    data: {
                      "email": widget.email,
                      "password": widget.password,
                      "name": name,
                      "gender": selectedGender,
                      "phoneNumber": phoneNumber,
                      "facultyCode": facultyId,
                      "isStudent": widget.isStudent,
                      if (!widget.isStudent) 
                        "lectureCode" : lecturerCode
                      else
                        "majorCode": majorId,
                        "class": selectedClass,
                    },
                    callback: (value) {
                      setState(() {
                        registerErrorMessage = value;
                      });
                    },
                    onPressed: () {
                      // final snackBar = SnackBar(
                      //   content: Text('Akun ${widget.email} berhasil dibuat'),
                      //   action: SnackBarAction(
                      //     label: 'Continue',
                      //     onPressed: () {
                      //       WidgetsBinding.instance
                      //           .addPostFrameCallback((timeStamp) {
                      //         Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               builder: (context) => const MainApp()),
                      //           (route) => false,
                      //         );
                      //       });
                      //     },
                      //   ),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackAlternative)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Signin(), // Replace YourSignInPage with the page you want to navigate to
                        ),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

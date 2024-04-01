import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/home_screen.dart';
import 'package:telu_project/screens/user_profile.dart';

class InviteStudent extends StatefulWidget {
  final projectTitle;
  const InviteStudent({Key? key, this.projectTitle});

  @override
  State<InviteStudent> createState() => _InviteStudentState();
}

class _InviteStudentState extends State<InviteStudent> {
  List<String> listRole = [
    "Back-End Developer",
    "Front-End Developer",
    "UI/UX Designer",
    "Data Scientist",
    "Data Analyst",
    "Business Analyst",
  ];

  final TextEditingController _messageController = TextEditingController(
    text: 'Hi, saya ingin mengundang kamu untuk bergabung ke project ini.',
  );

  List searchedStudents = [];
  Map<String, String>? selectedStudent;

  List student = [
    {
      'firstName': 'Muhammad',
      'lastName': 'Zaky Fathurahim',
      'role': 'Backend Developer',
      'profilePath': 'assets/images/stiv.png'
    },
    {
      'firstName': 'Muhammad',
      'lastName': 'Raihan Fasya',
      'role': 'UI/UX Designer',
      'profilePath': 'assets/images/rei.png'
    },
    {
      'firstName': 'Muhammad',
      'lastName': 'Reza adhie darmawan',
      'role': 'Frontend Developer',
      'profilePath': 'assets/images/reja.jpg'
    },
    {
      'firstName': 'Muhammad',
      'lastName': 'Hasnan Hunaini',
      'role': 'Turu Developer',
      'profilePath': 'assets/images/kebab.png'
    },
    {
      'firstName': 'Muhammad Naufal',
      'lastName': 'Zaki Kemana?',
      'role': 'Ngilang Developer',
      'profilePath': 'assets/images/nopal.png'
    },
    {
      'firstName': 'Surya',
      'lastName': 'Aulia',
      'role': 'Ngilang Developer',
      'profilePath': 'assets/images/suep.jpg'
    },
    {
      'firstName': 'Japran',
      'lastName': 'Aulia Zafran',
      'role': 'Ngilang Developer',
      'profilePath': 'assets/images/japrannn.png'
    }
  ];

  String? selectedRole;

  @override
  void initState() {
    super.initState();

    selectedRole = "Back-End Developer";
    selectedStudent = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.white,
            toolbarHeight: 200,
            flexibleSpace: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Invite Student',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          selectedStudent != null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const HomePage()),
                                  ),
                                )
                              : null;
                        },
                        child: Text(
                          'Send',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: selectedStudent != null
                                ? AppColors.tertiary
                                : AppColors.black.withOpacity(0.30),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.projectTitle,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Role',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: AppColors.black.withOpacity(0.30)),
                          color: AppColors.whiteAlternative,
                        ),
                        child: DropdownButton(
                          value: selectedRole,
                          onChanged: (String? value) {
                            setState(() {
                              selectedRole = value!;
                            });
                          },
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          iconSize: 24,
                          iconEnabledColor: AppColors.black,
                          underline: const SizedBox(),
                          isExpanded: true,
                          items: listRole.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      if (selectedStudent == null) ...[
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Find Student',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.black.withOpacity(0.30),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              searchStudents(value);
                            },
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Selected Student',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.black.withOpacity(0.30),
                              ),
                              color: AppColors.whiteAlternative,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => UserProfile(
                                          userData: selectedStudent,
                                        )),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                selectedStudent!['profilePath']
                                                    .toString(),
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                            width: 200,
                                            child: selectedStudent != null
                                                ? Text(
                                                    "${selectedStudent!['firstName']} ${selectedStudent?['lastName']}" ??
                                                        'No Student Selected',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: AppColors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  )
                                                : Text(
                                                    'No Student Selected',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: AppColors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: null,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        borderRadius: BorderRadius.circular(90),
                                        onTap: () {
                                          setState(() {
                                            selectedStudent = null;
                                          });
                                        },
                                        child: Icon(Icons.close))
                                  ],
                                ),
                              ),
                            )),
                      ],
                      if (selectedStudent == null)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "${searchedStudents.length} ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'Student Found',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, color: AppColors.black),
                                  ),
                                ],
                              )),
                        )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == searchedStudents.length) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Invitation Message',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type your message...',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.black.withOpacity(0.60),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(0.30),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: AppColors.black.withOpacity(0.30),
                                    )), // your
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(0.30),
                                  ), // Warna border saat fokus
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return selectedStudent == null
                          ? Container(
                              margin: EdgeInsets.fromLTRB(
                                  15,
                                  index == 0 ? 0 : 10,
                                  15,
                                  index == searchedStudents.length ? 20 : 0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedStudent = searchedStudents[index];
                                    searchedStudents = [];
                                  });
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            searchedStudents[index]
                                                ['profilePath'],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Text(
                                          searchedStudents[index]['firstName'] +
                                              " " +
                                              searchedStudents[index]
                                                  ['lastName'],
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : null;
                    }
                  },
                  childCount: searchedStudents.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchStudents(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchedStudents = student.where((student) {
          final firstNameMatches =
              student['firstName']!.toLowerCase().contains(query.toLowerCase());
          final lastNameMatches =
              student['lastName']!.toLowerCase().contains(query.toLowerCase());
          return firstNameMatches || lastNameMatches;
        }).toList();
      } else {
        searchedStudents = [];
      }
    });
  }
}

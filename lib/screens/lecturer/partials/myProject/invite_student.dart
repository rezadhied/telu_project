import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/screens/student/home_student.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/member_profile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class InviteStudent extends StatefulWidget {
  final projectTitle;
  final projectID;
  final projectRoles;
  const InviteStudent(
      {Key? key, this.projectTitle, this.projectID, this.projectRoles});

  @override
  State<InviteStudent> createState() => _InviteStudentState();
}

class _InviteStudentState extends State<InviteStudent> {
  final TextEditingController _messageController = TextEditingController(
    text: 'Hi, saya ingin mengundang kamu untuk bergabung ke project ini.',
  );

  List searchedStudents = [];
  Map<String, dynamic>? selectedStudent;
  bool isLoading = false;
  List listRole = [];
  // ignore: prefer_typing_uninitialized_variables
  var selectedRole;

  void findStudent(String value) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    final response = await http
        .get(Uri.parse('$url/students/search/$value/${widget.projectID}}'));

    if (response.statusCode == 200) {
      setState(() {
        searchedStudents = jsonDecode(response.body);
        if (searchedStudents.isEmpty) {
          searchedStudents = [];
        }
        print(searchedStudents);
      });
    } else {
      searchedStudents = [];
    }

    if (value == "") {
      setState(() {
        searchedStudents = [];
      });
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    selectedStudent = null;
    selectedRole = null;

    listRole = widget.projectRoles;
    print(listRole);
  }

  var isLoadingInvitation = false;

  void sendInvitation() async {
    if (mounted) {
      setState(() {
        isLoadingInvitation = true;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    // ignore: use_build_context_synchronously
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    print(
        '$userId ${selectedRole['roleID']}  ${selectedStudent!['userID']} ${widget.projectID}  ${_messageController.text}');
    var response = await http.post(Uri.parse('$url/invitation'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'senderID': userId,
          'roleID': selectedRole['roleID'],
          'receiverID': selectedStudent!['userID'],
          'projectID': widget.projectID,
          'message': _messageController.text,
        }));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg:
              "${selectedStudent!['firstName']} ${selectedStudent!['lastName']} has been invited",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.black,
          textColor: AppColors.white,
          fontSize: 16.0);
      setState(() {
        selectedStudent = null;
        selectedRole = null;
      });
      print('success invite');
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: json.decode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.black,
          textColor: AppColors.white,
          fontSize: 16.0);
    } else {
      print(json.decode(response.body)['error']);
    }
    if (mounted) {
      setState(() {
        isLoadingInvitation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Stack(
            children: [
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColors.white,
                toolbarHeight: 200,
                flexibleSpace: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
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
                            onTap: () async {
                              if (selectedStudent != null &&
                                  selectedRole != null) {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm Invitation"),
                                      content: Text(
                                          "Are you sure you want to invite ${selectedStudent!['firstName']} ${selectedStudent!['lastName']} ?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text("Invite"),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            sendInvitation();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              'Send',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: selectedStudent != null &&
                                        selectedRole != null
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
              if (isLoadingInvitation)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color:
                        Colors.black.withOpacity(0.1), // Semi-transparent color
                  ),
                ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
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
                              hint: Text(
                                'Select Role',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.60),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  selectedRole = value;
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
                              items: listRole.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value['Role']['name']),
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
                                  findStudent(value);
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
                                        builder: ((context) => MemberProfile(
                                              userId:
                                                  selectedStudent!['userID'],
                                            )),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(14),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                                child: const ClipOval(
                                                    // child: Image.asset(
                                                    //   selectedStudent!['profilePath']
                                                    //       .toString(),
                                                    //   width: 50,
                                                    //   height: 50,
                                                    //   fit: BoxFit.fill,
                                                    // ),
                                                    ),
                                              ),
                                              const SizedBox(width: 15),
                                              Container(
                                                width: 200,
                                                child: selectedStudent != null
                                                    ? Text(
                                                        "${selectedStudent!['firstName']} ${selectedStudent?['lastName']}" ??
                                                            'No Student Selected',
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                      )
                                                    : Text(
                                                        'No Student Selected',
                                                        style:
                                                            GoogleFonts.inter(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: null,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            onTap: () {
                                              setState(() {
                                                selectedStudent = null;
                                              });
                                            },
                                            child: const Icon(Icons.close))
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
                                            fontSize: 14,
                                            color: AppColors.black),
                                      ),
                                    ],
                                  )),
                            ),
                          isLoading
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : const SizedBox(),
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
                                        color:
                                            AppColors.black.withOpacity(0.30),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color:
                                              AppColors.black.withOpacity(0.30),
                                        )), // your
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.black.withOpacity(0.30),
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
                                      index == searchedStudents.length
                                          ? 20
                                          : 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedStudent =
                                            searchedStudents[index];
                                        searchedStudents = [];
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            child: const ClipOval(
                                                // child: Image.asset(
                                                //   searchedStudents[index]
                                                //       ['profilePath'],
                                                //   width: 50,
                                                //   height: 50,
                                                //   fit: BoxFit.fill,
                                                // ),
                                                ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Text(
                                              searchedStudents[index]
                                                      ['firstName'] +
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
            if (isLoadingInvitation)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color:
                      Colors.black.withOpacity(0.1), // Semi-transparent color
                ),
              ),
            // Centered CircularProgressIndicator
            if (isLoadingInvitation)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

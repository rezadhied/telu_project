import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/functions/formatter.dart';
import 'package:telu_project/helper/database_helper.dart';
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:telu_project/screens/lecturer/partials/myProject/invite_student.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/project_edit.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/member_profile.dart';

class MyProjectDetail extends StatefulWidget {
  final int id;

  const MyProjectDetail({super.key, required this.id});

  @override
  State<MyProjectDetail> createState() => _MyProjectDetailState();
}

class _MyProjectDetailState extends State<MyProjectDetail> {
  Future<Map<String, dynamic>> getProjectById() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';

    bool isConnectToInternet = await InternetConnection().hasInternetAccess;

    if (isConnectToInternet) {
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;

      if (SharedPreferencesHelper().getString("myProjectUpdate") == "false") {
        print("ambil dari local");
        return await getProjectByIdFromSqlLite();
      }

      final response = await http.get(Uri.parse('$url/project/${widget.id}'));

      if (response.statusCode != 200) {
        throw Exception('Failed to load project');
      } else {
        return json.decode(response.body);
      }
    } else {
      return await getProjectByIdFromSqlLite();
    }
  }

  Future<Map<String, dynamic>> getProjectByIdFromSqlLite() async {
    final db = await DatabaseHelper().database;
    final project = await db
        .query('Project', where: 'projectID = ?', whereArgs: [widget.id]);

    if (project.isNotEmpty) {
      final projectMembers = await db.query('ProjectMember',
          where: 'projectID = ?', whereArgs: [widget.id]);

      final projectRoles = await db
          .query('ProjectRole', where: 'projectID = ?', whereArgs: [widget.id]);

      List<Map<String, dynamic>> fullProjectMembers = [];
      List<Map<String, dynamic>> fullProjectRoles = [];

      for (var role in projectRoles) {
        final roleName = await db
            .query('Role', where: 'roleID = ?', whereArgs: [role['roleID']]);
        fullProjectRoles.add({
          'roleID': role['roleID'],
          'quantity': role['quantity'],
          'Role': {
            'name': roleName[0]['name'],
          }
        });
      }

      print(fullProjectRoles);

      for (var member in projectMembers) {
        Map<String, dynamic> memberMap = member as Map<String, dynamic>;
        String userID = memberMap['userID'];
        var user =
            await db.query('users', where: 'userID = ?', whereArgs: [userID]);
        var role = await db.query('Role',
            where: 'roleID = ?', whereArgs: [memberMap['roleID']]);

        fullProjectMembers.add({
          'projectMemberID': memberMap['projectMemberID'],
          'userID': memberMap['userID'],
          'roleID': memberMap['roleID'],
          'user': {
            'firstName': user[0]['firstName'],
            'lastName': user[0]['lastName'],
            'email': user[0]['email'],
            'photoProfileUrl': user[0]['photoProfileUrl'],
          },
          'Role': {
            'name': role[0]['name'],
          }
        });
      }

      return {
        'projectID': project[0]['projectID'],
        'title': project[0]['title'],
        'description': project[0]['description'],
        'startProject': project[0]['startProject'],
        'endProject': project[0]['endProject'],
        'openUntil': project[0]['openUntil'],
        'totalMember': project[0]['totalMember'],
        'groupLink': project[0]['groupLink'],
        'projectStatus': project[0]['projectStatus'],
        'createdAt': project[0]['createdAt'],
        "ProjectMembers": fullProjectMembers,
        "ProjectRoles": fullProjectRoles,
      };
    } else {
      throw Exception('Failed to load project');
    }
  }

  var isLoading = false;

  var update = false;

  void getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        isStudent = pref.getString("isStudent") == "true";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProjectById();
    getRole();
  }

  Formatter formatter = Formatter();

  bool isStudent = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: true,
        child: Scaffold(
            extendBody: true,
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColors.white,
                toolbarHeight: 200,
                flexibleSpace: SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.black.withOpacity(0.10)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context, update);
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Project Detail',
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
                                if (await InternetConnection()
                                    .hasInternetAccess) {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProjectEdit(
                                        projectId: widget.id,
                                      ),
                                    ),
                                  );
                                  if (result != null && result == 'updated') {
                                    setState(() {
                                      getProjectById();
                                      update = true;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'You are offline, please check your internet connection'),
                                    ),
                                  );
                                }
                              },
                              child: Icon(
                                !isStudent ? Icons.settings : Icons.info,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: FutureBuilder<Map<String, dynamic>>(
              future: getProjectById(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No project data found'));
                } else {
                  var projectData = snapshot.data!;
                  print(projectData);
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Project Title',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Text(
                                        '${projectData['title'] ?? "no title"}',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: AppColors.black)),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Project Status',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: projectData['projectStatus'] ==
                                                  'Active'
                                              ? AppColors.secondary
                                              : projectData['projectStatus'] ==
                                                      'Finished'
                                                  ? AppColors.primary
                                                  : projectData[
                                                              'projectStatus'] ==
                                                          'Open Request'
                                                      ? Colors.yellow
                                                      : projectData[
                                                                  'projectStatus'] ==
                                                              'Waiting to Start'
                                                          ? AppColors.tertiary
                                                          : AppColors.grey,
                                          borderRadius:
                                              BorderRadius.circular(90),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text('${projectData['projectStatus']} ',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: AppColors.black,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Project Description',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('${projectData['description']}',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppColors.black,
                                      )),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Project Duration',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                      '${formatter.formatDate(projectData['startProject'])} - ${formatter.formatDate(projectData['endProject'])}',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppColors.black,
                                      )),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Project Member'
                                        ' (${projectData['ProjectMembers'].length}/${projectData['totalMember']})',
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black),
                                      ),
                                      !isStudent
                                          ? InkWell(
                                              onTap: () async {
                                                if (await InternetConnection()
                                                    .hasInternetAccess) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: ((context) =>
                                                          InviteStudent(
                                                            projectTitle:
                                                                projectData[
                                                                    'title'],
                                                            projectID:
                                                                projectData[
                                                                    'projectID'],
                                                            projectRoles:
                                                                projectData[
                                                                    'ProjectRoles'],
                                                          )),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'You are offline, please check your internet connection'),
                                                    ),
                                                  );
                                                }
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: const Icon(
                                                  Icons.person_add,
                                                  color: AppColors
                                                      .quarternaryAlternative,
                                                ),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 250,
                                    child: ListView.builder(
                                        itemCount: projectData['ProjectMembers']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0,
                                                index == 0 ? 0 : 10,
                                                0,
                                                index ==
                                                        projectData[
                                                                'ProjectMembers']
                                                            .length
                                                    ? 20
                                                    : 0),
                                            child: InkWell(
                                              onTap: () async {
                                                if (await InternetConnection()
                                                    .hasInternetAccess) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          ((context) =>
                                                              MemberProfile(
                                                                userId: projectData[
                                                                            'ProjectMembers']
                                                                        [index]
                                                                    ['userID'],
                                                              )),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'You are offline, please check your internet connection'),
                                                    ),
                                                  );
                                                }
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape
                                                            .circle, // Mengatur bentuk container menjadi lingkaran
                                                        border: Border.all(
                                                          color: Colors
                                                              .black, // Opsional: Tambahkan border jika diperlukan
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                          'assets/images/stiv.png',
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${projectData['ProjectMembers'][index]['user']['firstName']} ${projectData['ProjectMembers'][index]['user']['lastName']}",
                                                            style: GoogleFonts
                                                                .inter(
                                                                    fontSize:
                                                                        16,
                                                                    color: AppColors
                                                                        .black),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "Role: ${projectData['ProjectMembers'][index]['Role']['name']}",
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.60),
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
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}

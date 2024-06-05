import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/helper/database_helper.dart';
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/create_project_screen.dart';
import 'package:telu_project/screens/my_project_detail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:telu_project/services/sync_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MyProjectLecturer extends StatefulWidget {
  const MyProjectLecturer({super.key});

  @override
  State<MyProjectLecturer> createState() => _MyProjectLecturerState();
}

class _MyProjectLecturerState extends State<MyProjectLecturer> {
  List<String> statusList = [
    'All',
    'Active',
    'Open Request',
    'Waiting to Start',
    'Finished',
  ];
  String? selectedStatus;
  String searchText = '';

  List projectList = [];
  List filteredProjects = [];
  bool isLoading = false;

  Future<void> fetchMyProjects() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';

    bool isConnectToInternet = await InternetConnection().hasInternetAccess;

    if (isConnectToInternet) {
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      SyncService syncData = SyncService(baseUrl: url, userId: userId);

      if (SharedPreferencesHelper().getString('myProjectUpdate') == "false") {
        print("no project update");
        await loadProjectsFromSQLite();
        return;
      }

      final response =
          await http.get(Uri.parse('$url/lecturer/projects/$userId'));

      if (response.statusCode == 200) {
        final List projects = json.decode(response.body);

        if (mounted) {
          if (SharedPreferencesHelper().getString('myProjectUpdate') ==
              "true") {
            await syncData.syncDataMyProjects(projects);
            await SharedPreferencesHelper()
                .setString("myProjectUpdate", "false");
          }
          setState(() {
            projectList = projects;

            filteredProjects = selectedStatus == 'All'
                ? projectList
                : projectList
                    .where(
                        (project) => project['projectStatus'] == selectedStatus)
                    .toList();
          });
        }
      } else {
        throw Exception('Failed to load projects');
      }
    } else {
      await loadProjectsFromSQLite();
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadProjectsFromSQLite() async {
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> rawProjects = await db.rawQuery('''
    SELECT 
      p.*, 
      u.firstName AS ownerFirstName, 
      u.lastName AS ownerLastName, 
      u.email AS ownerEmail,
      u.photoProfileUrl AS ownerPhotoProfileUrl
    FROM 
      Project p
    JOIN 
      users u ON p.projectOwnerID = u.userID
  ''');

    List<Map<String, dynamic>> projects = [];

    for (var rawProject in rawProjects) {
      int projectId = rawProject['projectID'];

      List<Map<String, dynamic>> projectRoles = await db.rawQuery('''
      SELECT 
        pr.roleID, 
        pr.quantity, 
        r.name AS roleName
      FROM 
        ProjectRole pr
      JOIN 
        Role r ON pr.roleID = r.roleID
      WHERE 
        pr.projectID = ?
    ''', [projectId]);

      List<Map<String, dynamic>> projectSkills = await db.rawQuery('''
      SELECT 
        ps.skillID, 
        s.name AS skillName
      FROM 
        ProjectSkill ps
      JOIN 
        Skill s ON ps.skillID = s.skillID
      WHERE 
        ps.projectID = ?
    ''', [projectId]);

      List<Map<String, dynamic>> projectMembers = await db.rawQuery('''
      SELECT 
        pm.projectMemberID, 
        pm.userID, 
        pm.roleID, 
        u.firstName, 
        u.lastName, 
        u.email, 
        u.photoProfileUrl, 
        r.name AS roleName
      FROM 
        ProjectMember pm
      JOIN 
        users u ON pm.userID = u.userID
      JOIN 
        Role r ON pm.roleID = r.roleID
      WHERE 
        pm.projectID = ?
    ''', [projectId]);

      projects.add({
        "projectID": rawProject['projectID'],
        "title": rawProject['title'],
        "projectOwnerID": rawProject['projectOwnerID'],
        "description": rawProject['description'],
        "startProject": rawProject['startProject'],
        "endProject": rawProject['endProject'],
        "openUntil": rawProject['openUntil'],
        "totalMember": rawProject['totalMember'],
        "groupLink": rawProject['groupLink'],
        "projectStatus": rawProject['projectStatus'],
        "createdAt": rawProject['createdAt'],
        "projectMemberCount": projectMembers.length,
        "projectOwner": {
          "userID": rawProject['projectOwnerID'],
          "firstName": rawProject['ownerFirstName'],
          "lastName": rawProject['ownerLastName'],
          "email": rawProject['ownerEmail'],
          "photoProfileUrl": rawProject['ownerPhotoProfileUrl'],
        },
        "ProjectRoles": projectRoles
            .map((role) => {
                  "roleID": role['roleID'],
                  "quantity": role['quantity'],
                  "Role": {
                    "name": role['roleName'],
                  }
                })
            .toList(),
        "ProjectSkills": projectSkills
            .map((skill) => {
                  "skillID": skill['skillID'],
                  "Skill": {
                    "name": skill['skillName'],
                  }
                })
            .toList(),
        "ProjectMembers": projectMembers
            .map((member) => {
                  "projectMemberID": member['projectMemberID'],
                  "userID": member['userID'],
                  "roleID": member['roleID'],
                  "user": {
                    "firstName": member['firstName'],
                    "lastName": member['lastName'],
                    "email": member['email'],
                    "photoProfileUrl": member['photoProfileUrl'],
                  },
                  "Role": {
                    "name": member['roleName'],
                  }
                })
            .toList(),
      });

      // print(projects);
    }

    if (mounted) {
      setState(() {
        projectList = projects;
        filteredProjects = selectedStatus == 'All'
            ? projectList
            : projectList
                .where((project) => project['projectStatus'] == selectedStatus)
                .toList();
      });
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchMyProjects();

    selectedStatus = statusList[0];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          onRefresh: fetchMyProjects,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Text(
                              'My Project',
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: AppColors.white,
                      floating: false,
                      pinned: false,
                      elevation: 0,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Find Your Projects',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: AppColors.black.withOpacity(0.30)),
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
                                  filterProjects(value);
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Filter',
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
                                value: selectedStatus,
                                onChanged: (String? value) {
                                  if (mounted) {
                                    setState(() {
                                      selectedStatus = value!;
                                      filterProjects(searchText);
                                    });
                                  }
                                },
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                                iconSize: 24,
                                iconEnabledColor: AppColors.black,
                                underline: const SizedBox(),
                                isExpanded: true,
                                items: statusList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          CreateProjectPage()),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Icon(
                                          Icons.addchart,
                                          size: 48.0,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Create New Project',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      isLoading
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 10,
                                              height: 10,
                                              child:
                                                  CircularProgressIndicator())
                                          : Text(
                                              "${filteredProjects.length} ",
                                              style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                      Text(
                                        'Projects',
                                        style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: AppColors.black),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isLoading
                        ? _buildLoadingSkeleton()
                        : Skeletonizer.sliver(
                            enabled: isLoading,
                            child: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        15,
                                        index == 0 ? 0 : 10,
                                        15,
                                        index == filteredProjects.length - 1
                                            ? 20
                                            : 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.grey, width: 1),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.white,
                                          filteredProjects[index]
                                                      ['projectStatus'] ==
                                                  'Active'
                                              ? AppColors.secondary
                                                  .withOpacity(0.1)
                                              : filteredProjects[index]
                                                          ['projectStatus'] ==
                                                      'Finished'
                                                  ? AppColors.primary
                                                      .withOpacity(0.1)
                                                  : filteredProjects[index][
                                                              'projectStatus'] ==
                                                          'Open Request'
                                                      ? Colors.yellow
                                                          .withOpacity(0.1)
                                                      : filteredProjects[index][
                                                                  'projectStatus'] ==
                                                              'Waiting to Start'
                                                          ? AppColors.tertiary
                                                              .withOpacity(0.1)
                                                          : AppColors.grey,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        var result = await Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    MyProjectDetail(
                                                      id: filteredProjects[
                                                          index]['projectID'],
                                                    )));

                                        if (result == true) {
                                          if (mounted) {
                                            setState(() {
                                              fetchMyProjects();
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: filteredProjects[index]
                                                            ['projectStatus'] ==
                                                        'Active'
                                                    ? AppColors.secondary
                                                    : filteredProjects[index][
                                                                'projectStatus'] ==
                                                            'Finished'
                                                        ? AppColors.primary
                                                        : filteredProjects[
                                                                        index][
                                                                    'projectStatus'] ==
                                                                'Open Request'
                                                            ? Colors.yellow
                                                            : filteredProjects[
                                                                            index]
                                                                        [
                                                                        'projectStatus'] ==
                                                                    'Waiting to Start'
                                                                ? AppColors
                                                                    .tertiary
                                                                : AppColors
                                                                    .grey,
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    filteredProjects[index]
                                                            ['title'] ??
                                                        '',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        color: AppColors.black),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Status: ${filteredProjects[index]['projectStatus']}',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: AppColors.black
                                                          .withOpacity(0.60),
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
                                },
                                childCount: filteredProjects.length,
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

  Widget _buildLoadingSkeleton() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Skeletonizer(
            enabled: true,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  15, index == 0 ? 0 : 10, 15, index == 9 ? 20 : 0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey, width: 1),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(90),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 20,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 3,
      ),
    );
  }

  void filterProjects(String query) {
    if (mounted) {
      setState(() {
        if (query.isNotEmpty || selectedStatus != null) {
          filteredProjects = projectList.where((project) {
            final titleMatches =
                project['title']!.toLowerCase().contains(query.toLowerCase());
            final statusMatches = selectedStatus == 'All' ||
                project['projectStatus'] == selectedStatus;
            return titleMatches && statusMatches;
          }).toList();
        } else {
          filteredProjects = List.from(projectList);
        }
      });
    }
  }
}

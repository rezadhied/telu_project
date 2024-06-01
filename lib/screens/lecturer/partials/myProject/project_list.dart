import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:telu_project/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/home_project_detail.dart';

class ListProject extends StatefulWidget {
  const ListProject({Key? key}) : super(key: key);

  @override
  State<ListProject> createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  List<Map<String, dynamic>> displayedProjects = [];
  List<dynamic> projects = [];
  bool isLoading = false;
  int currentPage = 1;
  final int projectsPerPage = 5;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchProjects();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchProjects({int page = 1}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiUrlProvider =
          Provider.of<ApiUrlProvider>(context, listen: false);
      String apiUrl = apiUrlProvider.baseUrl;
      final response = await http.get(Uri.parse(
          '$apiUrl/openRequestProjects?page=$page&limit=$projectsPerPage'));

      if (mounted) {
        if (response.statusCode == 200) {
          await Future.delayed(Duration(seconds: 2));
          projects = json.decode(response.body);
          setState(() {
            if (page == 1) {
              //projects = newProjects;
              displayedProjects =
                  projects.cast<Map<String, dynamic>>().take(5).toList();
            } else {
              //projects.addAll(newProjects);
              displayedProjects.addAll(projects.cast<Map<String, dynamic>>());
            }
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print(
              'Error: Failed to load projects. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        print('Error: $e');
      }
    }
  }

  void _loadMoreProjects() {
    currentPage++;
    if (mounted) {
      _fetchProjects(page: currentPage);
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !isLoading) {
      _loadMoreProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppColors.white,
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
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Project List',
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 5, bottom: 20, left: 15, right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.black.withOpacity(0.30)),
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
                  
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: displayedProjects.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < displayedProjects.length) {
                    return buildProjectItem(index);
                  } else {
                    return buildLoadingIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProjectItem(int index) {
    final project = displayedProjects[index];
    int totalMember = project['totalMember'] ?? 0;
    int projectMemberCount = project['projectMemberCount'] ?? 0;
    int availableSlots = totalMember - projectMemberCount;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeProjectDetail(
              projectData: project,
              isStudent: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteAlternative,
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        project["title"] ?? '',
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 30),
                Container(
                  child: Flexible(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "By: ${project['projectOwner']['firstName']} ${project['projectOwner']['lastName'][0]}.",
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    "Deskripsi",
                    style: GoogleFonts.inter(
                        color: AppColors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  child: Flexible(
                    child: Text(
                      project['description'] ?? '',
                      style: GoogleFonts.inter(color: AppColors.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    "Open Until",
                    style: GoogleFonts.inter(
                        color: AppColors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  child: Flexible(
                    child: Text(
                      DateFormat('d MMMM yyyy', 'id')
                          .format(DateTime.parse(project['openUntil'])),
                      style: GoogleFonts.inter(color: AppColors.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    "Open Recruitment",
                    style: GoogleFonts.inter(
                        color: AppColors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  child: Flexible(
                    child: Text(
                      "$availableSlots/${project['totalMember']} left",
                      style: GoogleFonts.inter(color: AppColors.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: CircularProgressIndicator(),
    );
  }
}

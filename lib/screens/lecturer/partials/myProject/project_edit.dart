import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/functions/formatter.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/project_edit_data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProjectEdit extends StatefulWidget {
  final int projectId;

  const ProjectEdit({super.key, required this.projectId});

  @override
  State<ProjectEdit> createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEdit> {
  Future<Map<String, dynamic>> getProjectById() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    final response =
        await http.get(Uri.parse('$url/project/${widget.projectId}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load project');
    } else {
      return json.decode(response.body);
    }
  }

  ValueNotifier<bool> _notifier = ValueNotifier(false);
  ValueNotifier<bool> _notifierDescription = ValueNotifier(false);
  ValueNotifier<bool> _notifierTitle = ValueNotifier(false);

  @override
  void dispose() {
    _notifier.dispose();
    _notifierDescription.dispose();
    _notifierTitle.dispose();
    super.dispose();
  }

  void handleEditStatus(String newStatus) async {
    status = newStatus;
  }

  void handleSave() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    final response = await http.put(
      Uri.parse('$url/projects/${widget.projectId}/status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newStatus': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update project status');
    }
    update = true;
    firstStatus = status;
    Fluttertoast.showToast(
        msg: "Status has been updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  final Formatter formatter = Formatter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    save = false;
    getStatus();
  }

  void getStatus() async {
    var projectData = await getProjectById();
    status = projectData['projectStatus'];
    firstStatus = projectData['projectStatus'];
  }

  bool save = false;

  String status = "";
  String firstStatus = "";

  bool update = false;

  Future<Map<String, dynamic>> project = Future.value({});

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
                            if (!update) {
                              Navigator.pop(context, 'not updated');
                            } else {
                              Navigator.pop(context, 'updated');
                            }
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Edit Project Info',
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
                        ValueListenableBuilder(
                            valueListenable: _notifier,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (status != firstStatus) {
                                        handleSave();
                                        save = false;
                                        _notifier.value = !_notifier.value;
                                      }
                                    },
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: save
                                            ? AppColors.tertiary
                                            : AppColors.black.withOpacity(0.30),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            })
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
                  print(status);
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Name',
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
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: _notifierTitle,
                                      builder: (context, value, child) {
                                        return Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.7,
                                          child: Text(
                                            '${projectData['title'] ?? "no title"}',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }),
                                  InkWell(
                                      onTap: () async {
                                        String value = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ProjectEditData(
                                                      nameColumn: "Title",
                                                      projectId: projectData[
                                                          'projectID'],
                                                      data:
                                                          projectData['title'],
                                                    ))));
                                        if (value != projectData['title'] &&
                                            value != '') {
                                          projectData['title'] = value;
                                          _notifierTitle.value =
                                              !_notifierTitle.value;
                                          update = true;
                                        }
                                      },
                                      child: Icon(Icons.arrow_right))
                                ],
                              )),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Owner',
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
                                onTap: () {},
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
                                                  'assets/images/ijad.jpg',
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Container(
                                                width: 200,
                                                child: Text(
                                                  projectData['projectOwner']
                                                          ['firstName'] +
                                                      ' ' +
                                                      projectData[
                                                              'projectOwner']
                                                          ['lastName'],
                                                  style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          statusSection(),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Date',
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
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Open Request Until",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            formatter.formatDate(
                                                projectData['openUntil']),
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
                                  Icon(Icons.arrow_right)
                                ],
                              )),
                          const SizedBox(height: 10),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Started Date",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            formatter.formatDate(
                                                projectData['startProject']),
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
                                  Icon(Icons.arrow_right)
                                ],
                              )),
                          const SizedBox(height: 10),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Ended Date",
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            formatter.formatDate(
                                                projectData['endProject']),
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )),
                                  Icon(Icons.arrow_right)
                                ],
                              )),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description',
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
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    child: ValueListenableBuilder(
                                        valueListenable: _notifierDescription,
                                        builder: (context, value, child) {
                                          return Text(
                                            projectData['description'],
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                          );
                                        }),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        String value = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ProjectEditData(
                                                      nameColumn: "Description",
                                                      projectId: projectData[
                                                          'projectID'],
                                                      data: projectData[
                                                          'description'],
                                                    ))));
                                        if (value !=
                                                projectData['description'] &&
                                            value != '') {
                                          projectData['description'] = value;
                                          _notifierDescription.value =
                                              !_notifierDescription.value;
                                          update = true;
                                        }
                                      },
                                      child: Icon(Icons.arrow_right))
                                ],
                              )),
                          const SizedBox(height: 20),
                        ]),
                      ),
                    ),
                  );
                }
              })),
    );
  }

  Widget statusSection() {
    @override
    void dispose() {
      _notifier.dispose();
      super.dispose();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Status',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        ValueListenableBuilder(
            valueListenable: _notifier,
            builder: (context, value, child) {
              return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.black.withOpacity(0.30),
                    ),
                  ),
                  child: Column(
                    children: [
                      statusItem(
                          'Active', () => {_notifier.value = !_notifier.value}),
                      statusItem('Finished',
                          () => {_notifier.value = !_notifier.value}),
                      statusItem('Open Request',
                          () => {_notifier.value = !_notifier.value}),
                      statusItem('Waiting to Start',
                          () => {_notifier.value = !_notifier.value}),
                    ],
                  ));
            })
      ],
    );
  }

  Widget statusItem(String statusName, Function callback) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.black.withOpacity(0.30),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: Text(
              statusName,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              handleEditStatus(statusName);
              save = firstStatus != status;
              callback();
            },
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color:
                    status == statusName ? AppColors.secondary : AppColors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/student/home_student.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProjectEditData extends StatefulWidget {
  final String nameColumn;
  final int projectId;
  final String data;

  const ProjectEditData(
      {super.key,
      required this.nameColumn,
      required this.projectId,
      required this.data});

  @override
  State<ProjectEditData> createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEditData> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = TextEditingValue(text: widget.data).text;
    firstData = textController.text;
  }

  String newData = '';
  String firstData = '';
  bool save = false;

  void updateData(String section) {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;

    if (section == "Description") {
      updateDescription(url);
    } else if (section == "Title") {
      updateTitle(url);
    }

    setState(() {
      save = false;
      firstData = textController.text;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void updateDescription(String url) async {
    final response = await http.put(
      Uri.parse('$url/projects/${widget.projectId}/description'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newDescription': textController.text,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update project status');
    } else {
      newData = textController.text;
    }
  }

  void updateTitle(String url) async {
    final response = await http.put(
      Uri.parse('$url/projects/${widget.projectId}/title'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newTitle': textController.text,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update project status');
    } else {
      newData = textController.text;
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
                          Navigator.pop(context, newData);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Edit ${widget.nameColumn}',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            onTap: () {
                              updateData(widget.nameColumn);
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.nameColumn}',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: TextField(
                            controller: textController,
                            onChanged: (value) {
                              print('n ' + value);
                              print('f ' + firstData);
                              if (firstData != value) {
                                setState(() {
                                  save = true;
                                });
                              } else {
                                setState(() {
                                  save = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter ${widget.nameColumn}',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black.withOpacity(0.30),
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

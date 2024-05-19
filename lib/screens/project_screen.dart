import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/invite_student.dart';
import 'package:telu_project/screens/project_edit.dart';
import 'package:telu_project/screens/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Project extends StatefulWidget {
  final int id;

  const Project({super.key, required this.id});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  var projectData = {};

  Future<void> getProjectById() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    final response = await http.get(Uri.parse('$url/project/${widget.id}'));

    if (response.statusCode != 200) {
      return;
    } else {
      final projects = json.decode(response.body);
      print(projects);
      setState(() {
        projectData = projects;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProjectById();
  }

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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => ProjectEdit()),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.settings,
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            child: Text('${projectData['title'] ?? "no title"}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: AppColors.black,
                                )),
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
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('Active',
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
                          Text(
                              'Menghijaukan pertanian untuk masyarakat Indonesia, khususnya di daerah Sukabirus dan Sukapura, merupakan langkah penting untuk meningkatkan kualitas hidup petani, menciptakan lingkungan yang berkelanjutan, dan memberikan kontribusi pada ketahanan pangan nasional.',
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
                          Text('25 Oktober 2023 - 25 Februari 2024',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black,
                              )),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Project Member'
                                ' (${projectData['member'].length}/10)',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => InviteStudent(
                                            projectTitle: projectData['title'],
                                          )),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.person_add,
                                    color: AppColors.quarternaryAlternative,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                                itemCount: projectData['member'].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0,
                                        index == 0 ? 0 : 10,
                                        0,
                                        index == projectData['member'].length
                                            ? 20
                                            : 0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) => UserProfile(
                                                  userData:
                                                      projectData['member']
                                                          [index],
                                                )),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  projectData['member'][index]
                                                      ['profilePath'],
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    projectData['member'][index]
                                                            ['firstName'] +
                                                        " " +
                                                        projectData['member']
                                                            [index]['lastName'],
                                                    style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        color: AppColors.black),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    'Role: ' +
                                                        projectData['member']
                                                            [index]['role'],
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
                                }),
                          )
                        ],
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

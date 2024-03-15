import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telu_project/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  List<String> statusList = <String>[
    'All',
    'Open Request',
    'Active',
    'Finished',
    'Waiting to Start'
  ];
  String? selectedStatus;
  String searchText = '';

  List projectList = [
    {
      'title': 'Proyek Bandara Internasional Soekarno-Hatta',
      'status': 'Active'
    },
    {'title': 'Proyek Tol Trans-Jawa', 'status': 'Open Request'},
    {'title': 'Proyek Jembatan Suramadu', 'status': 'Finished'},
    {
      'title': 'Proyek Kereta Api Cepat Jakarta-Bandung',
      'status': 'Waiting to Start'
    },
    {'title': 'Proyek Bendungan Karetan', 'status': 'Finished'},
    {'title': 'Proyek Konservasi Monumen Borobudur', 'status': 'Active'},
    {
      'title': 'Proyek Taman Nasional Gunung Leuser',
      'status': 'Waiting to Start'
    },
    {'title': 'Proyek Stadion Utama Gelora Bung Karno', 'status': 'Active'},
    {'title': 'Proyek Jalan Tol Bali Mandara', 'status': 'Open Request'},
    {'title': 'Proyek Bendungan Sutami', 'status': 'Finished'},
    {'title': 'Proyek Jalan Tol Trans-Sumatera', 'status': 'Active'},
    {'title': 'Proyek MRT Jakarta', 'status': 'Open Request'},
  ];
  List filteredProjects = [];

  @override
  void initState() {
    super.initState();
    selectedStatus = statusList.first;
    filteredProjects = projectList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Container(
              margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Text(
                'My Project',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              )),
          backgroundColor: AppColors.white,
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 15, 30, 50),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: AppColors.black.withOpacity(0.30)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      filterProjects(
                          value); // Panggil fungsi untuk memfilter proyek
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: AppColors.black.withOpacity(0.30)),
                      color: AppColors.whiteAlternative),
                  child: DropdownButton(
                    value: selectedStatus,
                    onChanged: (String? value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    style: GoogleFonts.inter(
                      fontSize: 16,
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
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(color: AppColors.black),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Create New Project',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  height: 400,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 1),
                      borderRadius: BorderRadius.circular(14)),
                  child: filteredProjects.isEmpty
                      ? const Center(
                          child: Text(
                            'No projects found.',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredProjects.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: AppColors.blackAlternative,
                                          borderRadius:
                                              BorderRadius.circular(90),
                                        ),
                                      ),
                                      Container(
                                        width: 300,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Flexible(
                                            child: Text(
                                          filteredProjects[index]['title'],
                                          overflow: TextOverflow.visible,
                                          softWrap: true,
                                        )),
                                      )
                                    ],
                                  ),
                                  const Text('tess')
                                ],
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void filterProjects(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProjects = projectList.where((project) {
          return project['title'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        filteredProjects = projectList;
      }
    });
  }
}

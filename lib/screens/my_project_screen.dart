import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/project_screen.dart';

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  List<String> statusList = [
    'All',
    'Active',
    'Open Request',
    'Waiting to Start',
    'Finished',
  ];
  String? selectedStatus;
  String searchText = '';

  List<Map<String, dynamic>> projectList = [
    {
      'title': 'Proyek Bandara Internasional Soekarno-Hatta',
      'status': 'Active',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Tol Trans-Jawa',
      'status': 'Open Request',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title':
          'Proyek Jembatan Suramadu Kereta Api Cepat Jakarta-Bandung Tol Trans-Jawa',
      'status': 'Finished',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Kereta Api Cepat Jakarta-Bandung',
      'status': 'Waiting to Start',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Bendungan Karetan',
      'status': 'Finished',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Konservasi Monumen Borobudur',
      'status': 'Active',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Taman Nasional Gunung Leuser',
      'status': 'Waiting to Start',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Stadion Utama Gelora Bung Karno',
      'status': 'Active',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Jalan Tol Bali Mandara',
      'status': 'Open Request',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Bendungan Sutami',
      'status': 'Finished',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek Jalan Tol Trans-Sumatera',
      'status': 'Active',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
    {
      'title': 'Proyek MRT Jakarta',
      'status': 'Open Request',
      'member': [
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        },
        {
          'firstName': 'Muhammad',
          'lastName': 'Zaky Fathurahim',
          'role': 'Backend Developer'
        }
      ]
    },
  ];

  List filteredProjects = [];

  @override
  void initState() {
    super.initState();
    selectedStatus = statusList[1];
    filteredProjects = List.from(projectList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'My Project',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              backgroundColor: AppColors.white,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
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
                            fontSize: 16,
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
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Filter',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.black.withOpacity(0.30)),
                        color: AppColors.whiteAlternative,
                      ),
                      child: DropdownButton(
                        value: selectedStatus,
                        onChanged: (String? value) {
                          setState(() {
                            selectedStatus = value!;
                            filterProjects(searchText);
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {},
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
                                padding: const EdgeInsets.only(left: 20),
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
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "${filteredProjects.length} ",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Projects',
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
                  return Container(
                    margin: EdgeInsets.fromLTRB(15, index == 0 ? 0 : 10, 15,
                        index == filteredProjects.length - 1 ? 20 : 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey, width: 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                project(projectData: filteredProjects[index])),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: filteredProjects[index]['status'] ==
                                        'Active'
                                    ? AppColors.secondary
                                    : filteredProjects[index]['status'] ==
                                            'Finished'
                                        ? AppColors.primary
                                        : filteredProjects[index]['status'] ==
                                                'Open Request'
                                            ? Colors.yellow
                                            : filteredProjects[index]
                                                        ['status'] ==
                                                    'Waiting to Start'
                                                ? AppColors.tertiary
                                                : AppColors.grey,
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredProjects[index]['title'] ?? '',
                                    style: GoogleFonts.inter(
                                        fontSize: 16, color: AppColors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Status: ${filteredProjects[index]['status']}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppColors.black.withOpacity(0.60),
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
          ],
        ),
      ),
    );
  }

  void filterProjects(String query) {
    setState(() {
      if (query.isNotEmpty || selectedStatus != null) {
        filteredProjects = projectList.where((project) {
          final titleMatches =
              project['title']!.toLowerCase().contains(query.toLowerCase());
          final statusMatches =
              selectedStatus == 'All' || project['status'] == selectedStatus;
          return titleMatches && statusMatches;
        }).toList();
      } else {
        filteredProjects = List.from(projectList);
      }
    });
  }
}

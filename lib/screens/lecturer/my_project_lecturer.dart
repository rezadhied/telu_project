import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:telu_project/class/User.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/create_project_screen.dart';
import 'package:telu_project/screens/my_project_detail.dart';
import 'package:provider/provider.dart';
import 'package:telu_project/screens/test.dart';
import 'package:http/http.dart' as http;

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

  // List projectList = [
  //   {
  //     'title': 'Proyek Bandara Internasional Soekarno-Hatta',
  //     'status': 'Active',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'Japran',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Tol Trans-Jawa',
  //     'status': 'Open Request',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title':
  //         'Proyek Jembatan Suramadu Kereta Api Cepat Jakarta-Bandung Tol Trans-Jawa',
  //     'status': 'Finished',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Kereta Api Cepat Jakarta-Bandung',
  //     'status': 'Waiting to Start',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Bendungan Karetan',
  //     'status': 'Finished',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Konservasi Monumen Borobudur',
  //     'status': 'Active',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Taman Nasional Gunung Leuser',
  //     'status': 'Waiting to Start',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Stadion Utama Gelora Bung Karno',
  //     'status': 'Active',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Jalan Tol Bali Mandara',
  //     'status': 'Open Request',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Bendungan Sutami',
  //     'status': 'Finished',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek Jalan Tol Trans-Sumatera',
  //     'status': 'Active',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  //   {
  //     'title': 'Proyek MRT Jakarta',
  //     'status': 'Open Request',
  //     'member': [
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Zaky Fathurahim',
  //         'role': 'Backend Developer',
  //         'profilePath': 'assets/images/stiv.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Raihan Fasya',
  //         'role': 'UI/UX Designer',
  //         'profilePath': 'assets/images/rei.png'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Reza adhie darmawan',
  //         'role': 'Frontend Developer',
  //         'profilePath': 'assets/images/reja.jpg'
  //       },
  //       {
  //         'firstName': 'Muhammad',
  //         'lastName': 'Hasnan Hunaini',
  //         'role': 'Turu Developer',
  //         'profilePath': 'assets/images/kebab.png'
  //       },
  //       {
  //         'firstName': 'Muhammad Naufal',
  //         'lastName': 'Zaki Kemana?',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/nopal.png'
  //       },
  //       {
  //         'firstName': 'Surya',
  //         'lastName': 'Aulia',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/suep.jpg'
  //       },
  //       {
  //         'firstName': 'japrannn',
  //         'lastName': 'Aulia Zafran',
  //         'role': 'Ngilang Developer',
  //         'profilePath': 'assets/images/japrannn.png'
  //       }
  //     ]
  //   },
  // ];

  List projectList = [];
  List filteredProjects = [];
  bool isLoading = false;

  Future<void> fetchMyProjects() async {
    setState(() {
      isLoading = true;
    });
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';
    final response =
        await http.get(Uri.parse('$url/lecturer/projects/$userId'));
    if (response.statusCode == 200) {
      final List projects = json.decode(response.body);
      if (mounted) {
        setState(() {
          projectList = projects;
          if (selectedStatus == 'All') {
            filteredProjects = projectList;
          } else {
            filteredProjects = projectList.where((project) {
              final statusMatches = project['projectStatus'] == selectedStatus;
              return statusMatches;
            }).toList();
          }
        });
      }
    } else {
      if (mounted) {
        setState(() {
          throw Exception('Failed to load projects');
        });
      }
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
                                          setState(() {
                                            fetchMyProjects();
                                          });
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

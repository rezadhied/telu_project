import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:telu_project/colors.dart';
import 'dart:async';

class ListProject extends StatefulWidget {
  const ListProject({Key? key}) : super(key: key);

  @override
  State<ListProject> createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  List<Map<String, dynamic>> displayedProjects = [];
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> projects = [
    {
      "projectID": 13,
      "title": "Project Green Campus",
      "projectOwnerID": "1302213451",
      "description": "Green Campus is a campus that is green",
      "startProject": "2024-01-06T01:14:58.000Z",
      "endProject": "2024-01-13T01:14:58.000Z",
      "openUntil": "2024-01-07T01:14:58.000Z",
      "totalMember": 10,
      "groupLink": "google.com",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:16:05.000Z",
      "updatedAt": "2024-01-06T01:16:05.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 10,
      "title": "Pengembangan Platform E-pinjem",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan platform e-pinjem yang dapat menyediakan pengalaman pinjem kelas dengan mudah.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 9,
      "title": "Pengembangan Platform E-commerce",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan platform e-commerce yang dapat menyediakan pengalaman belanja online yang mudah dan menyenangkan bagi pengguna.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 8,
      "title": "Pengembangan Teknologi Kesehatan",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini akan fokus pada pengembangan teknologi inovatif dalam bidang kesehatan untuk meningkatkan layanan dan pemantauan kesehatan masyarakat.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 7,
      "title": "Pengembangan Sistem Keamanan Cyber",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan sistem keamanan cyber yang handal untuk melindungi informasi penting dari serangan cyber yang merugikan.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 6,
      "title": "Pengembangan Aplikasi Analisis Data",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini akan fokus pada pengembangan aplikasi untuk menganalisis data besar dan menghasilkan informasi yang berguna untuk pengambilan keputusan.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 5,
      "title": "Pengembangan Sistem Manajemen Inventaris",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan sistem manajemen inventaris yang efisien untuk memantau dan mengelola stok barang secara real-time.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 4,
      "title": "Pengembangan Aplikasi Pencarian Tempat Makan",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan aplikasi yang memudahkan pengguna untuk mencari tempat makan terdekat berdasarkan preferensi dan lokasi mereka.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 3,
      "title": "Pengembangan Sistem Pemantauan Lingkungan Hidup",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan sistem yang dapat memantau kualitas lingkungan hidup dan memberikan informasi yang berguna bagi pengguna.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 2,
      "title": "Pengembangan Aplikasi Pengelolaan Keuangan Pribadi",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan aplikasi yang membantu pengguna dalam mengelola keuangan pribadi mereka dengan lebih efektif.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    },
    {
      "projectID": 1,
      "title": "Pengembangan Sistem Pencarian Lowongan Kerja",
      "projectOwnerID": "1302213451",
      "description":
          "Proyek ini bertujuan untuk mengembangkan sistem pencarian lowongan kerja yang efisien dan dapat membantu pengguna dalam mencari pekerjaan yang sesuai dengan keahlian dan preferensi mereka.",
      "startProject": "2023-10-25T01:30:00.000Z",
      "endProject": "2024-02-25T04:30:00.000Z",
      "openUntil": "2023-12-05T03:30:00.000Z",
      "totalMember": 10,
      "groupLink": "https://www.youtube.com/watch?v=bcHIwuUd9cs",
      "projectStatus": "Open Request",
      "createdAt": "2024-01-06T01:06:33.000Z",
      "updatedAt": "2024-01-06T01:06:33.000Z",
      "projectOwner": {"firstName": "Zaky Dosen", "lastName": "Fathurahim"}
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadProjects();
    _scrollController.addListener(_scrollListener);
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadProjects() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        displayedProjects.addAll(projects.take(4));
        isLoading = false;
      });
    });
  }

  void _loadMoreProjects() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        displayedProjects
            .addAll(projects.skip(displayedProjects.length).take(4));
        isLoading = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreProjects();
    }
  }

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    Align(
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.filter_alt_rounded)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: displayedProjects.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < displayedProjects.length) {
                    return buildProjectItem(displayedProjects[index]);
                  } else {
                    if (!isLoading) {
                      _loadMoreProjects();
                    }
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

  Widget buildProjectItem(Map<String, dynamic> project) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
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
                      project["title"],
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 30,
              ),
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
          SizedBox(
            height: 10,
          ),
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
              SizedBox(
                width: 5,
              ),
              Container(
                child: Flexible(
                  child: Text(
                    project['description'],
                    style: GoogleFonts.inter(color: AppColors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
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
              SizedBox(
                width: 5,
              ),
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
          )
        ],
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

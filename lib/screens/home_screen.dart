import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/class/User.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/home_project_detail.dart';
import 'package:telu_project/screens/project_list.dart';
import 'package:telu_project/screens/my_project_screen.dart';
import 'package:provider/provider.dart';
import 'package:telu_project/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Map<String, String>> projectList = [
    {
      'title': 'Proyek Bandara Internasional Soekarno-Hatta',
      'status': 'Open Request',
      'capacity': '1/4',
      'description':
          'Proyek ini bertujuan untuk meningkatkan fasilitas dan pelayanan di Bandara Internasional Soekarno-Hatta.',
      'lecturer': 'Dr. Ahmad',
      'project_start': '2022-04-10',
      'project_end': '2022-05-10'
    },
    {
      'title': 'Proyek Tol Trans-Jawa',
      'status': 'Open Request',
      'capacity': '2/4',
      'description':
          'Proyek ini bertujuan untuk memperbaiki jalan tol Trans-Jawa yang sudah rusak.',
      'lecturer': 'Prof. Budi',
      'project_start': '2022-04-15',
      'project_end': '2022-06-15'
    },
    {
      'title': 'Proyek Jembatan Baltimore',
      'status': 'Open Request',
      'capacity': '3/69',
      'description':
          'Proyek ini bertujuan untuk membangun jembatan baru di kota Baltimore.',
      'lecturer': 'Dr. Charlie',
      'project_start': '2022-05-01',
      'project_end': '2022-08-01'
    },
    {
      'title': 'Proyek Jembatan Suramadu',
      'status': 'Open Request',
      'capacity': '3/4',
      'description':
          'Proyek ini bertujuan untuk meningkatkan keamanan dan efisiensi lalu lintas di Jembatan Suramadu.',
      'lecturer': 'Prof. Dian',
      'project_start': '2022-06-01',
      'project_end': '2022-09-01'
    },
  ];

  late User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AuthProvider>(context, listen: false).getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            User? user = snapshot.data;
            return Scaffold(
              backgroundColor: AppColors.white,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Welcome, ',
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        )),
                    backgroundColor: AppColors.white,
                    floating: false,
                    pinned: false,
                    elevation: 0,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            width: 350,
                            height: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.quarternary
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text('Lecturer',
                                              style: GoogleFonts.inter(
                                                  color: AppColors.grey),
                                              textAlign: TextAlign.start),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            user != null
                                                ? '${user.firstName} ${user.lastName}'
                                                : 'Loading...',
                                            style: GoogleFonts.inter(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text('1 3 0 2 2 1 3 0 1 6',
                                              style: GoogleFonts.inter(
                                                  color: AppColors.grey,
                                                  fontSize: 16),
                                              textAlign: TextAlign.start),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Text('Projects',
                                            style: GoogleFonts.inter(
                                                color: AppColors.grey),
                                            textAlign: TextAlign.left),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '3',
                                          style: GoogleFonts.inter(
                                              color: AppColors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Text(
                            'Latest Projects',
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeProjectDetail(
                                    projectData: projectList[index],
                                    isStudent: true)));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                15, index == 0 ? 0 : 10, 15, 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.grey, width: 1),
                              borderRadius: BorderRadius.circular(14),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.white,
                                  AppColors.secondaryAlternative
                                      .withOpacity(0.1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        projectList[index]['title'] ?? '',
                                        style: GoogleFonts.inter(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Open Recruitment: ${projectList[index]['capacity'] ?? ''} left',
                                        style: GoogleFonts.inter(
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: projectList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side:
                                    const BorderSide(color: AppColors.primary),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListProject()));
                              },
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.quarternary
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'Find More',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}

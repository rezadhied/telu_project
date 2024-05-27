import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/class/User.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/student/partials/home/home_project_detail.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/project_list.dart';
import 'package:telu_project/screens/student/my_project_student.dart';
import 'package:provider/provider.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeLecturer extends StatefulWidget {
  const HomeLecturer({super.key});

  @override
  State<HomeLecturer> createState() => _HomeLecturer();
}

class _HomeLecturer extends State<HomeLecturer> {
  bool _isLoadingNewestProject = false;
  bool _showNoNewestProjectMessage = false;
  List<dynamic> _newestProject = [];
  int projectCount = 0;
  bool _isConnected = true;

  late User user;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    fetchNewestProjects();
    fetchMyProjects();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetSnackbar();
      setState(() {
        _isConnected = false;
      });
    } else {
      setState(() {
        _isConnected = true;
      });
    }
  }

  void _showNoInternetSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No Internet Connection'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> fetchMyProjects() async {
    await _checkConnectivity();
    if (!_isConnected) return;

    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';
    final response =
        await http.get(Uri.parse('$url/lecturer/projects/$userId'));

    if (response.statusCode == 200) {
      final List projects = json.decode(response.body);
      setState(() {
        projectCount = projects.length;
      });
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<void> fetchNewestProjects() async {
    await _checkConnectivity();
    if (!_isConnected) return;

    if (mounted) {
      setState(() {
        _isLoadingNewestProject = true;
      });
    }

    try {
      final apiUrlProvider =
          Provider.of<ApiUrlProvider>(context, listen: false);
      String apiUrl = apiUrlProvider.baseUrl;

      final response = await http.get(Uri.parse('$apiUrl/newestProjects'));

      if (response.statusCode == 200) {
        setState(() {
          _newestProject = jsonDecode(response.body);
          if (_newestProject.isEmpty) {
            _showNoNewestProjectMessage = true;
          }
        });
      } else {
        throw Exception('Failed to fetch newest projects');
      }
    } catch (error) {
      print("Failed to fetch newest projects: $error");
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingNewestProject = false;
        });
      }
    }
  }

  String addSpaces(String input) {
    return input.split('').join(' ');
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  Widget _buildLoadingSkeleton() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.fromLTRB(
                15, index == 0 ? 0 : 10, 15, index == 2 ? 20 : 0),
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
          );
        },
        childCount: 3,
      ),
    );
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
            body: RefreshIndicator(
              onRefresh: fetchNewestProjects,
              child: CustomScrollView(
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
                      ),
                    ),
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
                                ],
                              ),
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
                                          child: Text(
                                            user != null
                                                ? capitalize(user.role)
                                                : 'Loading...',
                                            style: GoogleFonts.inter(
                                                color: AppColors.grey),
                                            textAlign: TextAlign.start,
                                          ),
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
                                          child: Text(
                                            user != null
                                                ? addSpaces(user.userID)
                                                : 'Loading...',
                                            style: GoogleFonts.inter(
                                                color: AppColors.grey,
                                                fontSize: 16),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Projects',
                                          style: GoogleFonts.inter(
                                              color: AppColors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          '$projectCount',
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
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLoadingNewestProject
                      ? _buildLoadingSkeleton()
                      : _newestProject.isEmpty
                          ? SliverToBoxAdapter(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    2, 
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.wifi_off,
                                        size: 80,
                                        color: AppColors.grey,
                                      ),
                                      Text(
                                        'No Internet Connection',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final project = _newestProject[index];
                                  return GestureDetector(
                                    onTap: () {
                                      print(project);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeProjectDetail(
                                            projectData: project,
                                            isStudent: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          15, index == 0 ? 0 : 10, 15, 0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.grey, width: 1),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary,
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
                                                  project['title'] ?? '',
                                                  style: GoogleFonts.inter(
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Open Recruitment: ${project['totalMember'] - project['projectMemberCount']}/${project['totalMember'] ?? ''} left',
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
                                childCount: _newestProject.length,
                              ),
                            ),
                  if (_isConnected)
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
                                  side: const BorderSide(
                                      color: AppColors.primary),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ListProject()),
                                  );
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
            ),
          );
        }
      },
    );
  }
}

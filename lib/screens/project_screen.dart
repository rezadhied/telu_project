import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/invite_student.dart';
import 'package:telu_project/screens/user_profile.dart';

class Project extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const Project({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: AppColors.white,
            toolbarHeight: 200,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
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
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          projectData['title'],
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.settings,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
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
                        'Project Status',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color : AppColors.black
                        ),
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
                          color : AppColors.black
                        ),
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
                          color : AppColors.black
                        ),
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
                              color : AppColors.black
                            ),
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
                                              userData: projectData['member']
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
                                                    projectData['member'][index]
                                                        ['lastName'],
                                                style: GoogleFonts.inter(
                                                    fontSize: 16,
                                                    color: AppColors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'Role: ' +
                                                    projectData['member'][index]
                                                        ['role'],
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
    );
  }
}

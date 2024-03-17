import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';

class project extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const project({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    Container(
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
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: const Icon(
                        Icons.settings,
                      ),
                    ),
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
                margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Status',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                            'Project Member' +
                                ' (${projectData['member'].length}/10)',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.person_add,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: projectData['member'].length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    index == 0 ? 0 : 10,
                                    0,
                                    index == 4 ? 20 : 0),
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/my_project_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Map<String, String>> projectList = [
    {'title': 'Proyek Bandara Internasional Soekarno-Hatta', 'status': 'Open Request', 'capacity' : '1/4'},
    {'title': 'Proyek Tol Trans-Jawa', 'status': 'Open Request', 'capacity' : '2/4'},
    {'title': 'Proyek Jembatan Suramadu', 'status': 'Open Request', 'capacity' : '3/4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My Projects',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: 450,
                    height: 250,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Text(
                                    'YOLO - Tracking Truck With AI',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'By: Jonathan Maulana',
                                    style: GoogleFonts.inter(color: Colors.black),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text('Deskripsi',
                                      style: GoogleFonts.inter(color: Colors.grey),
                                      textAlign: TextAlign.start),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    width: 300,
                                    height: 100,
                                    child: Text(
                                      'YOLO (You Only Look Once) adalah sebuah algoritma deteksi objek real-time untuk pengolahan citra dan video. Tujuan dari algoritma ini adalah untuk mendeteksi dan mengklasifikasikan objek dalam suatu gambar secara akurat dan efisien.',
                                      style: GoogleFonts.inter(color: Colors.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text('Project End',
                                      style: GoogleFonts.inter(color: Colors.grey),
                                      textAlign: TextAlign.left),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 300,
                                  child: Text(
                                    '5 Desember 2024',
                                    style: GoogleFonts.inter(color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
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
                  padding: const EdgeInsets.all(8.0),
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
                return Container(
                  margin: EdgeInsets.fromLTRB(15, index == 0 ? 0 : 10, 15, 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: AppColors.blackAlternative,
                          borderRadius: BorderRadius.circular(90),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              projectList[index]['title'] ?? '',
                              style: GoogleFonts.inter(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Open Recruitment: ${projectList[index]['capacity'] ?? ''} left',
                              style: GoogleFonts.inter(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        side: const BorderSide(color: AppColors.primary),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyProject()));
                      },
                      child: const Text('Find More'),
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
}

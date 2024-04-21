import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';

class RequestDetail extends StatefulWidget {
  const RequestDetail({super.key});

  @override
  State<RequestDetail> createState() => _RequestDetail();
}

class _RequestDetail extends State<RequestDetail> {
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
                            'Proyek ambassing',
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
                  height: 550,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteAlternative,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          'Requested By',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                        const SizedBox(height: 5),
                        Text('Fasya Reza Fathurrahim',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                            )),
                        const SizedBox(height: 25),
                        Text(
                          'Message',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            'Saya sangat menyukai singing, maka dari itu saya ingin join proyek ambassing. Semoga bapak/ibu dapat menerima saya dalam pengerjaan proyek ambassing ini. Ambasssinggg',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                            )),
                        const SizedBox(height: 25),
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
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.whiteAlternative,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                        ),
                        onPressed: () {
                        },
                        child: Text(
                          'Approve'
                          ),
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.primaryAlternative,
                          foregroundColor: AppColors.whiteAlternative,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                        ),
                        onPressed: () {
                        },
                        child: Text('Decline'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

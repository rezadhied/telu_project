import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';

class UserProfile extends StatelessWidget {
  final userData;

  const UserProfile({super.key, required this.userData});

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
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'User Profile',
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
                    ),
                    const Icon(
                      Icons.settings,
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
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
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
                              userData['profilePath'],
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Name',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(userData['firstName'],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black,
                              )),
                          const SizedBox(width: 5),
                          Text(userData['lastName'],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black,
                              ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Class',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('SE-45-02',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          )),
                      const SizedBox(height: 15),
                      Text(
                        'Major',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Informatics',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          )),
                      const SizedBox(height: 15),
                      Text(
                        'About',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Lebih baik sahur daripada tidak sahur',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          )),
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:http/http.dart' as http;
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:provider/provider.dart';

class MemberProfile extends StatelessWidget {
  final String userId;

  const MemberProfile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> getUserData() async {
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      final response = await http.get(Uri.parse('$url/users/$userId'));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    }

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
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var userData = snapshot.data!;
                  return SafeArea(
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
                                      child: userData['photoProfileUrl'] == null
                                          ? Image.asset(
                                              'assets/images/defaultProfile.png',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              userData['photoProfileUrl'],
                                              width: 50,
                                              height: 50,
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
                                    Text('${userData['firstName']}',
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
                                Text(userData['kelas'],
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: AppColors.black,
                                    )),
                                const SizedBox(height: 15),
                                Text(
                                  'Faculty',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(userData['facultyName'],
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
                  );
                }
              })),
    );
  }
}

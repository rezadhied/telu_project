import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/lecturer/inbox_lecturer.dart';

class RequestDetail extends StatefulWidget {
  final Request request;

  const RequestDetail({super.key, required this.request});

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              backgroundColor: AppColors.white,
              toolbarHeight: 250,
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
                      const SizedBox(
                          width: 10), // Jarak antara tombol kembali dan judul
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              widget.request.firstName,
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
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
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteAlternative,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
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
                        Text(
                          widget.request.firstName,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Message',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(widget.request.message,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
                        Text(widget.request.projectDescription,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk menyetujui request
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Approve',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk menolak request
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color.fromRGBO(254, 251, 246, 1),
          child: Stack(children: <Widget>[
            Positioned(
              top: 10,
              left: 20,
              child: Text(
                'Project',
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 30),
                        child: Text(
                          'YOLO - Tracking Truck With AI',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            color: AppColors.black,
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 0.8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 100),
                        child: Text(
                          'Fasya Maulana St. Mptm',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.grey,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 39,
                          height: 39,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white,
                          ),
                          child: Image.asset(
                            'assets/images/nopal.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Team',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'Computer Vision',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 110),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white,
                              ),
                              child: Image.asset(
                                'assets/images/rei.png', // Ganti dengan path gambar Anda
                                fit: BoxFit.cover,
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
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 340,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 2,
                          )
                        ],
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Please fill these questions to convince me that you',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: AppColors.black,
                                fontSize: 13,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                            Text(
                              'intend to follow this project.',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: AppColors.black,
                                fontSize: 13,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 280,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    // BORDER ATAS 1
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.grey,
                          ),
                          child: Center(
                            child: Text(
                              '1', // Isi dengan teks angka yang Anda inginkan
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors
                                    .black, // Sesuaikan warna teks dengan kebutuhan Anda
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apa Tujuan Mu ?',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 260,
                          height: 55,
                          decoration: BoxDecoration(
                            // BORDER BAWAH 3
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: TextField(
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              color: AppColors.black,
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none, // Menghilangkan garis tepi TextField
                              contentPadding: EdgeInsets
                                  .zero, // Menghilangkan padding di dalam TextField
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 410,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    // BORDER ATAS 2
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.grey,
                          ),
                          child: Center(
                            child: Text(
                              '2', // Isi dengan teks angka yang Anda inginkan
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors
                                    .black, // Sesuaikan warna teks dengan kebutuhan Anda
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apa Tujuan Mu ?',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 470,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 260,
                          height: 55,
                          decoration: BoxDecoration(
                            // BORDER BAWAH 3
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: TextField(
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              color: AppColors.black,
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none, // Menghilangkan garis tepi TextField
                              contentPadding: EdgeInsets
                                  .zero, // Menghilangkan padding di dalam TextField
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 540,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    // BORDER ATAS 3
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.grey,
                          ),
                          child: Center(
                            child: Text(
                              '3', // Isi dengan teks angka yang Anda inginkan
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors
                                    .black, // Sesuaikan warna teks dengan kebutuhan Anda
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apa Tujuan Mu ?',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 260,
                          height: 55,
                          decoration: BoxDecoration(
                            // BORDER BAWAH 3
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: TextField(
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              color: AppColors.black,
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder
                                  .none, // Menghilangkan garis tepi TextField
                              contentPadding: EdgeInsets
                                  .zero, // Menghilangkan padding di dalam TextField
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 670,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 60,
                  decoration: BoxDecoration(
                    // BORDER ATAS 4
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload Your CV',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 730,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 340,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Panggil fungsi upload CV di sini
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            'pdf',
                            'doc',
                            'docx',
                            'jpg',
                            'jpeg',
                            'png'
                          ],
                        );
                        if (result != null) {
                          // Lakukan sesuatu dengan file yang dipilih
                          print(
                              'Path file yang dipilih: ${result.files.single.path}');
                          print(
                              'Nama file yang dipilih: ${result.files.single.name}');
                        } else {
                          // Tidak ada file yang dipilih
                          print('Tidak ada file yang dipilih.');
                        }
                      },
                      child: Text(
                        'Unggah CV',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan fungsi untuk meng-handle submit di sini
                    // Misalnya:
                    print('Tombol Submit ditekan');
                  },
                  child: Text(
                    'Submit',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

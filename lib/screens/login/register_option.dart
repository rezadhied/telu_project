import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/login/register.dart';

class RegisterOption extends StatefulWidget {
  const RegisterOption({super.key});

  @override
  State<RegisterOption> createState() => _RegisterOptionState();
}

class _RegisterOptionState extends State<RegisterOption> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.black, width: 2),
                        borderRadius: BorderRadius.circular(22.0)),
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: [
                              'assets/images/loginImage1.jpg',
                              'assets/images/loginImage2.png',
                              'assets/images/loginImage3.png',
                            ].map((String imagepath) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  imagepath,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: double.infinity,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [0, 1, 2].map((index) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? AppColors.primary
                                        : AppColors.white.withOpacity(0.50),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Tel-U Project',
                            style: GoogleFonts.inter(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Center(
                            child: Text(
                          'Discover your dream project or help \ncreate one.',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.black,
                                side: const BorderSide(
                                  color: AppColors.black,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                ),
                                padding:const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                backgroundColor: AppColors.white, // Set background color to transparent
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const Register(isStudent: true),
                                ));
                              },
                              child: const Text('Join as Student'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.black,
                                  side:
                                      const BorderSide(color: AppColors.black),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  backgroundColor: AppColors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const Register(isStudent: false)));
                                },
                                child: const Text('Join as Lecturer'),
                              ),
                            ),
                          ),
                        ],
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
  }
}

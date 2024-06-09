import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/student/project_join.dart';

class HomeProjectDetail extends StatefulWidget {
  final Map<String, dynamic> projectData;
  final bool isStudent;

  

  const HomeProjectDetail(
      {Key? key,
      this.projectData = const {
        "title": 'Title',
        'status': 'Open Request',
        'capacity': '1/4',
        'description':
            'DESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSKEEEEERIIIIPPPPPPPPPPPPPPPSIIIIII',
        'lecture': 'Dr. lecturer',
        'project_start': '2022-04-10',
        'project_end': '2022-05-10'
      },
      required this.isStudent});

  @override
  State<HomeProjectDetail> createState() => _HomeProjectDetailState();
}

class _HomeProjectDetailState extends State<HomeProjectDetail> {

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString); // Parse the date string into DateTime
    return DateFormat('dd MMMM yyyy', 'en_US').format(dateTime); // Format the date
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 30),
                child: Text(
                  widget.projectData['title'],
                  style:  GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Text(widget.projectData['description'])),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: Text(
                    "Project Leader",
                    style: GoogleFonts.inter(
                        color: AppColors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "${widget.projectData['projectOwner']['firstName']} ${widget.projectData['projectOwner']['lastName']} ",
                    style: GoogleFonts.inter(
                        color: AppColors.blackAlternative,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child:  Text(
                    "Project Duration",
                    style: GoogleFonts.inter(
                        color: AppColors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 9),
                  child: Text(
                    "${formatDateString(widget.projectData['startProject'])} -  ${formatDateString(widget.projectData['endProject'])}",
                    style: GoogleFonts.inter(
                        color: AppColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Adjust the border radius as needed
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white),
                      child: Text('Back'),
                    ),
                  ),
                  SizedBox(width: 16), // Add space between buttons
                  widget.isStudent
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinProject()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Adjust the border radius as needed
                                ),
                                backgroundColor: AppColors.secondary,
                                foregroundColor: AppColors.white),
                            child: Text('Request To Join'),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

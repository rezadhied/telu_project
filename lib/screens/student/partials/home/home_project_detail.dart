import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/student/project_join.dart';

class HomeProjectDetail extends StatelessWidget {
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
                margin: EdgeInsets.only(bottom: 9),
                child: Text(
                  projectData['title'],
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Text(projectData['description'])),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: const Text(
                    "Project Leader",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w200),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "${projectData['projectOwner']['firstName']} ${projectData['projectOwner']['lastName']} ",
                    style: TextStyle(
                        color: AppColors.blackAlternative,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: const Text(
                    "Project Duration",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w200),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 9),
                  child: Text(
                    "${projectData['startProject']} -  ${projectData['endProject']}",
                    style: TextStyle(
                        color: AppColors.blackAlternative,
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
                  isStudent
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

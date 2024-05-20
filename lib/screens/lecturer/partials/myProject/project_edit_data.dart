import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/student/home_student.dart';

class ProjectEditData extends StatefulWidget {
  final String nameColumn;
  final String projectId;
  final String data;

  const ProjectEditData(
      {Key? key,
      required this.nameColumn,
      required this.projectId,
      this.data = "tess"})
      : super(key: key);

  @override
  State<ProjectEditData> createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEditData> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = TextEditingValue(text: widget.data).text;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.white,
            toolbarHeight: 200,
            flexibleSpace: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.black.withOpacity(0.10)))),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Edit ${widget.nameColumn}',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black.withOpacity(0.30),
                              ),
                              textAlign: TextAlign.center,
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
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.nameColumn}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.black.withOpacity(0.30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter ${widget.nameColumn}',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black.withOpacity(0.30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

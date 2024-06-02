import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:telu_project/screens/student/partials/inbox/inbox_detail.dart';

class InboxStudent extends StatefulWidget {
  const InboxStudent({super.key});

  @override
  State<InboxStudent> createState() => _InboxStudentState();
}

class _InboxStudentState extends State<InboxStudent> {
  late dynamic prefs;
  List<dynamic> dataInvitation = [];
  List<dynamic> filteredDataInvitation = [1];
  String selectedFilter = 'All';
  bool isLoading = false;

  Future<void> fetchInvitation() async {
    setState(() {
      isLoading = true;      
    });
    try {
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      prefs = await SharedPreferences.getInstance();
      if (mounted) {
        final response = await http
            .get(Uri.parse('$url/invitation/${prefs.getString("userId")}'));
        setState(() {
          dataInvitation = json.decode(response.body);
          filteredDataInvitation = dataInvitation;
        });
      }
    } catch (e) {
      print("Error :$e");
    }
    setState(() {
      isLoading = false;
    });
  }

  void filterData(String status) {
    setState(() {
      selectedFilter = status;
      if (status == 'All') {
        filteredDataInvitation = dataInvitation;
      } else {
        filteredDataInvitation = dataInvitation
            .where((invitation) => invitation["status"] == status)
            .toList();
      }
    });
  }

  Color getBackgroundColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.yellow[50]!;
      case 'rejected':
        return Colors.red[50]!;
      case 'accepted':
        return Colors.green[50]!;
      default:
        return Colors.white;
    }
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd', 'en_US');
    final DateFormat timeFormatter = DateFormat('h:mm a', 'en_US');
    final DateFormat dayMonthFormatter = DateFormat('dd-MMM', 'en_US');
    final DateFormat fullDateFormatter = DateFormat('dd-MMM-yyyy', 'en_US');

    if (dateFormatter.format(date) == dateFormatter.format(now)) {
      // If the date is today, return the time in h:mm a format
      return timeFormatter.format(date);
    } else if (dateFormatter.format(date) ==
        dateFormatter.format(now.subtract(Duration(days: 1)))) {
      // If the date is yesterday
      return "Yesterday";
    } else if (date.year == now.year) {
      // If the date is in this year, return in dd-MMM format
      return dayMonthFormatter.format(date);
    } else {
      // If the date is in a previous year, return in dd-MMM-yyyy format
      return fullDateFormatter.format(date);
    }
  }

  ButtonStyle getButtonStyle(String status) {
    return ElevatedButton.styleFrom(
      foregroundColor: selectedFilter == status ? AppColors.white : AppColors.black,
      backgroundColor:
          selectedFilter == status ? AppColors.primary : Colors.grey[50],
    );
  }

  @override
  void initState() {
    super.initState();
    fetchInvitation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 150.0, // Adjust this height as needed
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 20, bottom: 40),
                  title: Text(
                    'Inbox',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                backgroundColor: AppColors.white,
                floating: true,
                pinned: true,
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => filterData('All'),
                          child: Text('All'),
                          style: getButtonStyle('All'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => filterData('waiting'),
                          child: Text('Waiting'),
                          style: getButtonStyle('waiting'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => filterData('accepted'),
                          child: Text('Accepted'),
                          style: getButtonStyle('accepted'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => filterData('rejected'),
                          child: Text('Rejected'),
                          style: getButtonStyle('rejected'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return isLoading ? Expanded(child : Center(child: CircularProgressIndicator())) : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => InboxDetail(invitationData: filteredDataInvitation[index], 
                                    date: formatDate(
                                      filteredDataInvitation[index]["createdAt"]
                                      ),
                                    callback: fetchInvitation,
                                    )
                                  )
                                );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: getBackgroundColor(
                              filteredDataInvitation[index]["status"]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${filteredDataInvitation[index]["sender"]["firstName"]} ${filteredDataInvitation[index]["sender"]["lastName"]}',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              filteredDataInvitation[index]["message"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              formatDate(
                                  filteredDataInvitation[index]["createdAt"]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.black,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: filteredDataInvitation.length,
                ),
              )
            ],
          ),
        ));
  }
}

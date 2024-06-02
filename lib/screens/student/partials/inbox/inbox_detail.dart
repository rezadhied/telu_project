import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InboxDetail extends StatefulWidget {
  dynamic invitationData;
  String date;
  Function() callback;

  InboxDetail({super.key, required this.invitationData, required this.date, required this.callback});

  @override
  State<InboxDetail> createState() => _InboxDetailState();
}

class _InboxDetailState extends State<InboxDetail> {

  sendResponseInvitation(String status) async {
    try {
      Navigator.of(context).pop();
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      var request =
          http.MultipartRequest('POST', Uri.parse('$url/invitationResponse'));

      // Add fields to the request
      request.fields['invitationID'] = widget.invitationData["invitationID"].toString();
      request.fields['roleID'] = widget.invitationData["roleID"].toString();
      request.fields['projectID'] = widget.invitationData["projectID"].toString();
      request.fields['status'] = status;
      request.fields['receiverID'] = widget.invitationData["receiverID"].toString();

      // Send the request
      var response = await request.send();

      print('Response received: ${await response.stream.bytesToString()}');
      widget.callback();
    } catch (error) {
      // Handle error
      print('Send Invitation Response Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(30, 70, 30, 40),
            width: double.infinity,
            color: getBackgroundColor(widget.invitationData["status"]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios_rounded),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'We Invited You to "${widget.invitationData["Project"]["title"]}"',
                  style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.invitationData["sender"]["firstName"]} ${widget.invitationData["sender"]["lastName"]}',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.date}',
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: AppColors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.invitationData["message"],
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    SizedBox(height: 36),
                    if (widget.invitationData["status"] == "waiting")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => sendResponseInvitation("accepted"),
                            child: Text(
                              "Accepted",
                              style: GoogleFonts.inter(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.black,
                              backgroundColor: Colors.green[50],
                              shadowColor: Colors.transparent,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => sendResponseInvitation("rejected"),
                            child: Text("Rejected",
                                style: GoogleFonts.inter(fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.black,
                              backgroundColor: Colors.red[50],
                              shadowColor: Colors.transparent,
                            ),
                          )
                        ],
                      )
                    else if (widget.invitationData["status"] == "accepted")
                      Text(
                        "Accepted",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight : FontWeight.w700,
                          color: Colors.green[200],
                        ),
                      )
                    else
                      Text(
                        "Rejected",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight : FontWeight.w700,
                          color: Colors.red[200],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

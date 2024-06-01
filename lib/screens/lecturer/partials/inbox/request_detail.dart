import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/lecturer/inbox_lecturer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class RequestDetail extends StatefulWidget {
  final Request request;

  const RequestDetail({super.key, required this.request});

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  Future<void> _downloadPdf() async {
    final apiUrlProvider = Provider.of<ApiUrlProvider>(context, listen: false);
    String apiUrl = apiUrlProvider.baseUrl;
    final url = 'http://10.0.2.2:5000/request/${widget.request.requestID}/download';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final Directory tempDir = await getTemporaryDirectory();
        final String filePath = '${tempDir.path}/cv_${widget.request.requestID}.pdf';
        final File file = File(filePath);
        await file.writeAsBytes(bytes);

        // Minta izin penyimpanan
        final status = await Permission.storage.request();
        if (status.isGranted) {
          final Directory? downloadDir = await getExternalStorageDirectory();
          final String downloadPath = '${downloadDir!.path}/cv_${widget.request.requestID}.pdf';
          final File downloadFile = File(downloadPath);
          await downloadFile.writeAsBytes(bytes);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('PDF downloaded to $downloadPath'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Storage permission denied'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to download PDF. Status code: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  Future<void> _declineRequest() async {
    final apiUrlProvider = Provider.of<ApiUrlProvider>(context, listen: false);
    String apiUrl = apiUrlProvider.baseUrl;

    final urlUpdateStatus = '$apiUrl/changeStatus/${widget.request.requestID}';

    try {
      final responseStatus = await http.patch(
        Uri.parse(urlUpdateStatus),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': 'rejected'}),
      );

      if (responseStatus.statusCode == 200) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update request status. Status code: ${responseStatus.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  Future<void> _acceptRequest() async {
    final apiUrlProvider = Provider.of<ApiUrlProvider>(context, listen: false);
    String apiUrl = apiUrlProvider.baseUrl;

    final urlUpdateStatus = '$apiUrl/changeStatus/${widget.request.requestID}';
    final urlAddMember = '$apiUrl/addNewMEM';

    try {
      final responseStatus = await http.patch(
        Uri.parse(urlUpdateStatus),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': 'accepted'}),
      );

      if (responseStatus.statusCode == 200) {
        final newMemberData = {
          'projectID': widget.request.projectID,
          'userID': widget.request.userID,
          'roleID': widget.request.roleID,
        };

        final responseMember = await http.post(
          Uri.parse(urlAddMember),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newMemberData),
        );

        if (responseMember.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Request accepted and member added successfully'),
          ));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to add new member. Status code: ${responseMember.statusCode}'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update request status. Status code: ${responseStatus.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

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
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            'Request Detail',
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
                        '${widget.request.firstName} ${widget.request.lastName}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Project',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(widget.request.projectName,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.black,
                          )),
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
                        'Document',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('View document',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.black,
                              )),
                          IconButton(
                            icon: Icon(Icons.download),
                            onPressed: _downloadPdf,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _acceptRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _declineRequest,
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
      ),
    );
  }
}

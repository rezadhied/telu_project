import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/lecturer/partials/inbox/request_detail.dart';

class InboxLecturer extends StatefulWidget {
  const InboxLecturer({super.key});

  @override
  State<InboxLecturer> createState() => _InboxLecturerState();
}

class Request {
  final int requestID;
  final String userID;
  final int roleID;
  final String message;
  final String firstName;
  final String lastName;
  final String roleName;
  final int projectID;
  final String projectName;
  final String projectDescription;
  final String projectOwnerID;
  final String startProject;
  final String endProject;
  final String openUntil;
  final int totalMember;
  final String groupLink;
  final String projectStatus;
  final String projectCreatedAt;
  final String projectUpdatedAt;

  Request({
    required this.requestID,
    required this.userID,
    required this.roleID,
    required this.message,
    required this.firstName,
    required this.lastName,
    required this.roleName,
    required this.projectID,
    required this.projectName,
    required this.projectDescription,
    required this.projectOwnerID,
    required this.startProject,
    required this.endProject,
    required this.openUntil,
    required this.totalMember,
    required this.groupLink,
    required this.projectStatus,
    required this.projectCreatedAt,
    required this.projectUpdatedAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      requestID: json['requestID'],
      userID: json['userID'],
      roleID: json['roleID'],
      message: json['message'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      roleName: json['Role']['name'],
      projectID: json['projectID'],
      projectName: json['project']['title'],
      projectDescription: json['project']['description'],
      projectOwnerID: json['project']['projectOwnerID'],
      startProject: json['project']['startProject'],
      endProject: json['project']['endProject'],
      openUntil: json['project']['openUntil'],
      totalMember: json['project']['totalMember'],
      groupLink: json['project']['groupLink'],
      projectStatus: json['project']['projectStatus'],
      projectCreatedAt: json['project']['createdAt'],
      projectUpdatedAt: json['project']['updatedAt'],
    );
  }
}

class _InboxLecturerState extends State<InboxLecturer> {
  List<Request> originalRequests = [];
  List<Request> filteredRequests = [];

  Future<void> fetchRequests() async {
    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';
    final response = await http.get(Uri.parse('$url/requestMember/$userId'));
    if (response.statusCode == 200) {
      final List projectsJson = json.decode(response.body);
      setState(() {
        originalRequests = projectsJson.expand((projectJson) {
          return (projectJson['Requests'] as List).map((requestJson) {
            return Request.fromJson({...requestJson, 'project': projectJson});
          });
        }).toList();
        filteredRequests = originalRequests;
      });
    } else {
      throw Exception('Failed to load requests');
    }
  }

  void filterRequest(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRequests = originalRequests;
      } else {
        filteredRequests = originalRequests.where((request) {
          final fullName =
              '${request.firstName} ${request.lastName}'.toLowerCase();
          final searchLower = query.toLowerCase();
          return fullName.contains(searchLower) ||
              request.message.toLowerCase().contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Requested',
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
              margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Find Request',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: AppColors.black.withOpacity(0.30)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestDetail(
                          request: filteredRequests[index],
                        ),
                      ),
                    );
                  },
                  child: RequestItem(request: filteredRequests[index]),
                );
              },
              childCount: filteredRequests.length,
            ),
          ),
        ],
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  final Request request;

  const RequestItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Colors.grey, width: 0.7),
      ),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestDetail(
                request: request,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.firstName + ' ' + request.lastName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          request.projectName,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          request.roleName,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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

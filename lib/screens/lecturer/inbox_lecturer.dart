import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/lecturer/partials/inbox/request_detail.dart';

List<Request> originalRequests = [];
List<Request> filteredRequests = [];

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
  bool isLoading = false;
  bool isLoadingConfirmation = false;

  void filterRequest(String query) {
    if (mounted) {
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
  }

  Future<void> fetchRequests() async {
    if (!mounted) return;
    setState(() {
      filteredRequests = [];
      originalRequests = [];
      isLoading = true;
    });

    String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('userId') ?? '';
    final response = await http.get(Uri.parse('$url/requestMember/$userId'));

    if (!mounted) return;

    if (response.statusCode == 200) {
      final List projectsJson = json.decode(response.body);

      if (mounted) {
        setState(() {
          originalRequests = projectsJson.expand((projectJson) {
            return (projectJson['Requests'] as List).map((requestJson) {
              return Request.fromJson({...requestJson, 'project': projectJson});
            });
          }).toList();
          filteredRequests = originalRequests;
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      throw Exception('Failed to load requests');
    }
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
      body: RefreshIndicator(
        onRefresh: fetchRequests,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                    margin: EdgeInsets.only(bottom: 10),
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
                  floating: false,
                  pinned: false,
                  elevation: 0,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: AppColors.black.withOpacity(0.30)),
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
                            onChanged: (value) {
                              filterRequest(value);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "${filteredRequests.length} ",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'Request',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, color: AppColors.black),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                filteredRequests.isEmpty && !isLoading
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'Belum ada Request',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    : SliverList(
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
                              child: RequestItem(
                                request: filteredRequests[index],
                                onRequestUpdated: fetchRequests,
                                onLoadingChanged: (value) {
                                  setState(() {
                                    isLoadingConfirmation = value;
                                    print(isLoadingConfirmation);
                                  });
                                },
                              ),
                            );
                          },
                          childCount: filteredRequests.length,
                        ),
                      ),
              ],
            ),
            if (isLoading || isLoadingConfirmation)
              Positioned.fill(
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (isLoadingConfirmation)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RequestItem extends StatefulWidget {
  final Request request;
  final Future<void> Function() onRequestUpdated;
  final Function(bool) onLoadingChanged;

  const RequestItem(
      {super.key,
      required this.request,
      required this.onRequestUpdated,
      required this.onLoadingChanged});

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  bool isLoading = false;

  void decline(int requestID) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Decline"),
          content: Text("Are you sure you want to decline this request?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Decline"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        widget.onLoadingChanged(true);
        print("masuk");
      });

      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      final response = await http.patch(
        Uri.parse('$url/changeStatus/$requestID'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': 'rejected'}),
      );

      if (response.statusCode == 200) {
        widget.onRequestUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Berhasil decline request ${widget.request.firstName}'),
          ),
        );
      } else {
        throw Exception('Failed to decline request');
      }

      if (mounted) {
        setState(() {
          isLoading = false;
          widget.onLoadingChanged(false);
          print("masuk $isLoading ${widget.onLoadingChanged}");
        });
      }
    }
  }

  void approve(int requestID) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Approve"),
          content: Text("Are you sure you want to approve this request?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Approve"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        widget.onLoadingChanged(true);
      });

      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      final response = await http.patch(
        Uri.parse('$url/changeStatus/$requestID'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': 'accepted'}),
      );

      await http.post(
        Uri.parse('$url/addNewMEM'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'projectID': widget.request.projectID,
          'userID': widget.request.userID,
          'roleID': widget.request.roleID
        }),
      );

      await SharedPreferencesHelper().setString("myProjectUpdate", "true");

      if (!mounted) return;

      if (response.statusCode == 200) {
        widget.onRequestUpdated();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Berhasil approve request ${widget.request.firstName}'),
          ),
        );
      } else {
        throw Exception('Failed to approve request');
      }

      if (mounted) {
        setState(() {
          isLoading = false;
          widget.onLoadingChanged(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Colors.grey, width: 0.7),
      ),
      elevation: 0,
      color: Colors.white,
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestDetail(
                    request: widget.request,
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
                              widget.request.firstName +
                                  ' ' +
                                  widget.request.lastName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.request.projectName,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.request.roleName,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
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
                        onPressed: () async {
                          approve(widget.request.requestID);
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
                        onPressed: () async {
                          decline(widget.request.requestID);
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
          ),
        ],
      ),
    );
  }
}

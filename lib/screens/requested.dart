import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/request_detail.dart';

class Requested extends StatefulWidget {
  const Requested({super.key});

  @override
  State<Requested> createState() => _RequestedState();
}

class _RequestedState extends State<Requested> {
  List<Request> originalRequests = [
    Request(
      name: "Muhammad Zaky Fathurahim",
      project: "Proyek supersemar batmans ambasing Happy birthday",
      role: "Back-End Developer",
      photo: "ijad.jpg",
    ),
    Request(
      name: "Fasya Raihan Maulana",
      project: "Proyek Konservasi Monumen Borobudur",
      role: "Back-End Developer",
      photo: "nopal.jpg",
    ),
    Request(
      name: "Hasnan Husaini",
      project: "Proyek perampokan cayo perico",
      role: "Back-End Developer",
      photo: "kebab.png",
    ),
  ];

  List<Request> filteredRequests = [];

  @override
  void initState() {
    filteredRequests = originalRequests;
    super.initState();
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
                      onChanged: (value) {
                        filterRequest(value);
                      },
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

  void filterRequest(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRequests = originalRequests;
      } else {
        filteredRequests = originalRequests.where((request) =>
            request.name.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }
}

class Request {
  String name;
  String project;
  String role;
  String photo;

  Request({
    required this.name,
    required this.project,
    required this.role,
    required this.photo,
  });
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
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/${request.photo}'),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          request.project,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          request.role,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
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

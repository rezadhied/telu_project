import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datatTimePicker;
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/components/text_field_component.dart';
import 'package:telu_project/components/button_component.dart';
import 'package:telu_project/screens/student/my_project_student.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreateProjectPage extends StatefulWidget {
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  TextEditingController _projectTitleController = TextEditingController();
  TextEditingController _groupChatLinkController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _roleNameController = TextEditingController();
  TextEditingController _roleQuantityController = TextEditingController();
  TextEditingController _skillController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime _opreqDate = DateTime.now();

  List<Map<String, dynamic>> _roles = [];
  List<String> _skills = [];

  bool _isInputComplete = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _projectTitleController.addListener(_checkInputCompletion);
    _groupChatLinkController.addListener(_checkInputCompletion);
    _descriptionController.addListener(_checkInputCompletion);
  }

  void _checkInputCompletion() {
    setState(() {
      _isInputComplete = _projectTitleController.text.isNotEmpty &&
          _projectTitleController.text.length > 2 &&
          _groupChatLinkController.text.isNotEmpty &&
          _groupChatLinkController.text.contains('.com') &&
          _descriptionController.text.isNotEmpty &&
          _descriptionController.text.length > 11 &&
          _roles.isNotEmpty;
    });
  }

  Future<void> _handleSubmit() async {
    if (_isInputComplete) {
      setState(() {
        isLoading = true;
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      String userID = pref.getString('userId') ?? '';
      int maxMembers =
          _roles.fold(0, (sum, role) => sum + role['quantity'] as int);

      List<Map<String, dynamic>> rolesData = _roles.map((role) {
        return {
          'name': role['name'],
          'quantity': role['quantity'],
        };
      }).toList();

      Map<String, dynamic> projectData = {
        'projectTitle': _projectTitleController.text,
        'currentUserId': userID,
        'description': _descriptionController.text,
        'startDate': _startDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
        'opreqDate': _opreqDate.toIso8601String(),
        'maxMembers': maxMembers,
        'groupChatLink': _groupChatLinkController.text,
        'skillTags': _skills,
        'roles': rolesData,
      };

      if (await InternetConnection().hasInternetAccess) {
        try {
          final apiUrlProvider =
              Provider.of<ApiUrlProvider>(context, listen: false);
          String apiUrl = apiUrlProvider.baseUrl;
          final response = await http.post(
            Uri.parse('$apiUrl/projects'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(projectData),
          );
          setState(() {
            isLoading = true;
          });
          if (response.statusCode == 201) {
            await SharedPreferencesHelper()
                .setString("myProjectUpdate", "true");
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainApp(
                  selectedIndex: 1,
                ),
              ),
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create project.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No internet connection')),
        );
      }
    }
  }

  void _handleAddSkill() {
    String input = _skillController.text;
    List<String> newSkills = input.split(',').map((e) => e.trim()).toList();

    if (mounted) {
      setState(() {
        _skills.clear();
        for (String skill in newSkills) {
          if (skill.isNotEmpty) {
            _skills.add(skill);
          }
        }
      });
    }
  }

  void _handleAddRole() {
    String roleName = _roleNameController.text;
    int roleQuantity = int.tryParse(_roleQuantityController.text) ?? 0;
    if (roleName.isNotEmpty && roleQuantity > 0) {
      if (mounted) {
        setState(() {
          _roles.add({'name': roleName, 'quantity': roleQuantity});
          _roleNameController.clear();
          _roleQuantityController.clear();
        });
      }
    }
    _checkInputCompletion();
  }

  void _handleSkillTagClick(int index) {
    if (mounted) {
      setState(() {
        _skills.removeAt(index);
      });
    }
  }

  void _handleRoleTagClick(int index) {
    if (mounted) {
      setState(() {
        _roles.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.white,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  backgroundColor: AppColors.white,
                  toolbarHeight: 200,
                  flexibleSpace: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              'Create Project',
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: () {
                                if (_isInputComplete &&
                                    _skills.isNotEmpty &&
                                    _roles.isNotEmpty) {
                                  _handleSubmit();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Create project failed. Please fill in all required fields.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Create',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _isInputComplete &&
                                          _skills.isNotEmpty &&
                                          _roles.isNotEmpty
                                      ? AppColors.tertiary
                                      : AppColors.black.withOpacity(0.30),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _projectTitleController,
                        decoration: InputDecoration(
                          hintText: 'Project Title',
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        maxLines: 1,
                        onChanged: (value) {
                          _checkInputCompletion();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                        maxLines: 5,
                        onChanged: (value) {
                          _checkInputCompletion();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _groupChatLinkController,
                        decoration: InputDecoration(
                          hintText: 'Group Chat Link',
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          _checkInputCompletion();
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  datatTimePicker.DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      if (mounted) {
                                        setState(() {
                                          _startDate = date;
                                        });
                                      }
                                    },
                                    currentTime: _startDate,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            AppColors.black.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'MM-DD-YYYY',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                    ),
                                    controller: TextEditingController(
                                        text: _startDate != null
                                            ? "${_startDate.month}-${_startDate.day}-${_startDate.year}"
                                            : ""),
                                    readOnly: true,
                                    onTap: () {
                                      datatTimePicker.DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          if (mounted) {
                                            setState(() {
                                              _startDate = date;
                                            });
                                          }
                                        },
                                        currentTime: _startDate,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  datatTimePicker.DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      if (mounted) {
                                        setState(() {
                                          _endDate = date;
                                        });
                                      }
                                    },
                                    currentTime: _endDate,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            AppColors.black.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'MM-DD-YYYY',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                    ),
                                    controller: TextEditingController(
                                        text: _endDate != null
                                            ? "${_endDate.month}-${_endDate.day}-${_endDate.year}"
                                            : ""),
                                    readOnly: true,
                                    onTap: () {
                                      datatTimePicker.DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          if (mounted) {
                                            setState(() {
                                              _endDate = date;
                                            });
                                          }
                                        },
                                        currentTime: _endDate,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex:
                              3, // Fleksibilitas lebih besar untuk field "Open Recruitment Until"
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Open Recruitment Until',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  datatTimePicker.DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      if (mounted) {
                                        setState(() {
                                          _opreqDate = date;
                                        });
                                      }
                                    },
                                    currentTime: _opreqDate,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            AppColors.black.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'MM-DD-YYYY',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                    ),
                                    controller: TextEditingController(
                                        text: _endDate != null
                                            ? "${_opreqDate.month}-${_opreqDate.day}-${_opreqDate.year}"
                                            : ""),
                                    readOnly: true,
                                    onTap: () {
                                      datatTimePicker.DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          if (mounted) {
                                            setState(() {
                                              _opreqDate = date;
                                            });
                                          }
                                        },
                                        currentTime: _opreqDate,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ), // Spasi antara field "Open Recruitment Until" dan "Maximum Member"
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Skill (seperate with coma ' , ')",
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          controller: _skillController,
                          maxLines: 1,
                          onChanged: (value) {
                            _handleAddSkill();
                            _checkInputCompletion();
                          }),
                    ),
                    Wrap(
                      spacing: 8,
                      children: _skills
                          .asMap()
                          .entries
                          .map(
                            (entry) => InkWell(
                              onTap: () => _handleSkillTagClick(entry.key),
                              child: Chip(
                                label: Text(
                                  '${entry.value}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.tertiary,
                                deleteIcon:
                                    Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.black.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextField(
                                controller: _roleNameController,
                                decoration: InputDecoration(
                                  hintText: 'Role Name',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                ),
                                maxLines: 1,
                                onChanged: (value) {
                                  _checkInputCompletion();
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.black.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextField(
                                controller: _roleQuantityController,
                                decoration: InputDecoration(
                                  hintText: 'Qty',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                ),
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.white,
                                backgroundColor: AppColors.secondary,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              ),
                              onPressed: _handleAddRole,
                              child: const Text('Add Role'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: _roles
                          .asMap()
                          .entries
                          .map(
                            (entry) => InkWell(
                              onTap: () => _handleRoleTagClick(entry.key),
                              child: Chip(
                                label: Text(
                                  '${entry.value['name']} (${entry.value['quantity']})',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: AppColors.quarternary,
                                deleteIcon:
                                    Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            )),
        isLoading
            ? Stack(
                children: [
                  // BackdropFilter for the blur effect
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.1), // Semi-transparent color
                    ),
                  ),
                  // Centered CircularProgressIndicator
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

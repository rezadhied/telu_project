import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:telu_project/helper/database_helper.dart';

class SyncService {
  final String baseUrl;
  final String userId;

  SyncService({required this.baseUrl, required this.userId});

  Future<void> syncDataMyProjects(List<dynamic> projects) async {
    if (true) {
      final db = await DatabaseHelper().database;

      await db.delete('Project');
      await db.delete('ProjectMember');
      await db.delete('ProjectRole');
      await db.delete('ProjectSkill');
      await db.delete('Role');
      await db.delete('Skill');
      await db.delete('Users');

      for (var project in projects) {
        await db.insert(
            'users',
            {
              'userID': project['projectOwnerID'],
              'firstName': project['projectOwner']['firstName'],
              'lastName': project['projectOwner']['lastName'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace);

        await db.insert(
            'Project',
            {
              'projectID': project['projectID'],
              'title': project['title'],
              'projectOwnerID': project['projectOwnerID'],
              'description': project['description'],
              'startProject': project['startProject'],
              'endProject': project['endProject'],
              'openUntil': project['openUntil'],
              'totalMember': project['totalMember'],
              'groupLink': project['groupLink'],
              'projectStatus': project['projectStatus'],
              'createdAt': project['createdAt']
            },
            conflictAlgorithm: ConflictAlgorithm.replace);

        final projectResponse = await http
            .get(Uri.parse('$baseUrl/project/${project['projectID']}'));

        if (projectResponse.statusCode == 200) {
          Map<String, dynamic> project = json.decode(projectResponse.body);

          for (var role in project['ProjectRoles']) {
            await db.insert(
              'Role',
              {
                'roleID': role['roleID'],
                'name': role['Role']['name'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await db.insert(
                'ProjectRole',
                {
                  'roleID': role['roleID'],
                  'projectID': project['projectID'],
                  'quantity': role['quantity'],
                },
                conflictAlgorithm: ConflictAlgorithm.replace);
          }

          for (var skill in project['ProjectSkills']) {
            await db.insert(
              'Skill',
              {
                'skillID': skill['skillID'],
                'name': skill['Skill']['name'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await db.insert(
                'ProjectSkill',
                {
                  'skillID': skill['skillID'],
                  'projectID': project['projectID'],
                },
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
        }

        for (var member in project['ProjectMembers']) {
          await db.insert(
              'ProjectMember',
              {
                'projectMemberID': member['projectMemberID'],
                'userID': member['userID'],
                'roleID': member['roleID'],
                'projectID': project['projectID'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace);

          final userResponse =
              await http.get(Uri.parse('$baseUrl/users/${member['userID']}'));
          if (userResponse.statusCode == 200) {
            Map<String, dynamic> user = json.decode(userResponse.body);
            await db.insert(
                'users',
                {
                  'userID': user['userID'],
                  'firstName': user['firstName'],
                  'lastName': user['lastName'],
                  'gender': user['gender'],
                  'kelas': user['kelas'],
                  'facultyCode': user['facultyCode'],
                  'majorCode': user['majorCode'],
                  'phoneNumber': user['phoneNumber'],
                  'photoProfileImage': user['photoProfileImage'],
                  'photoProfileUrl': user['photoProfileUrl'],
                },
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
        }
      }
    }
  }
}

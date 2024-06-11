import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:telu_project/helper/database_helper.dart';

class SyncService {
  final String baseUrl;
  final String userId;

  SyncService({required this.baseUrl, required this.userId});

  Future<void> syncDataMyProjects(List<dynamic> projects) async {
    print(projects);

    final db = await DatabaseHelper().database;

    await db.transaction((txn) async {
      await txn.delete('Project');
      await txn.delete('ProjectMember');
      await txn.delete('ProjectRole');
      await txn.delete('ProjectSkill');
      await txn.delete('Role');
      await txn.delete('Skill');
      await txn.delete('Users');
    });

    final client = http.Client();

    for (var project in projects) {
      await db.transaction((txn) async {
        await txn.insert(
          'users',
          {
            'userID': project['projectOwnerID'],
            'firstName': project['projectOwner']['firstName'],
            'lastName': project['projectOwner']['lastName'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await txn.insert(
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
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      final projectResponse = await client
          .get(Uri.parse('$baseUrl/project/${project['projectID']}'));

      if (projectResponse.statusCode == 200) {
        Map<String, dynamic> projectData = json.decode(projectResponse.body);

        await db.transaction((txn) async {
          for (var role in projectData['ProjectRoles']) {
            await txn.insert(
              'Role',
              {
                'roleID': role['roleID'],
                'name': role['Role']['name'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await txn.insert(
              'ProjectRole',
              {
                'roleID': role['roleID'],
                'projectID': projectData['projectID'],
                'quantity': role['quantity'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }

          for (var skill in projectData['ProjectSkills']) {
            await txn.insert(
              'Skill',
              {
                'skillID': skill['skillID'],
                'name': skill['Skill']['name'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await txn.insert(
              'ProjectSkill',
              {
                'skillID': skill['skillID'],
                'projectID': projectData['projectID'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });

        for (var member in projectData['ProjectMembers']) {
          await db.transaction((txn) async {
            await txn.insert(
              'ProjectMember',
              {
                'projectMemberID': member['projectMemberID'],
                'userID': member['userID'],
                'roleID': member['roleID'],
                'projectID': projectData['projectID'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          });

          final userResponse =
              await client.get(Uri.parse('$baseUrl/users/${member['userID']}'));
          if (userResponse.statusCode == 200) {
            Map<String, dynamic> user = json.decode(userResponse.body);
            await db.transaction((txn) async {
              await txn.insert(
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
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            });
          }
        }
      }
    }
    client.close();
  }
}

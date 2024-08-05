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

    final startTime = DateTime.now(); // Start time

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
    final List<Future<void>> futures = [];

    for (var project in projects) {
      futures.add(_syncProject(db, client, project));
    }

    await Future.wait(futures);
    client.close();

    final endTime = DateTime.now(); // End time
    final duration = endTime.difference(startTime); // Calculate duration

    print('Sync completed in ${duration.inSeconds} seconds');
  }

  Future<void> _syncProject(
      Database db, http.Client client, dynamic project) async {
    try {
      await db.transaction((txn) async {
        // Debug statement to check the types of values being inserted
        print(
            'Inserting project owner: ${project['projectOwnerID']} ${project['projectOwner']['firstName']} ${project['projectOwner']['lastName']}');

        await txn.insert(
          'users',
          {
            'userID': project['projectOwnerID'], // Ensure the ID is a String
            'firstName': project['projectOwner']['firstName'].toString(),
            'lastName': project['projectOwner']['lastName'].toString(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        print('Inserting project: ${project['projectID']} ${project['title']}');

        await txn.insert(
          'Project',
          {
            'projectID': project['projectID'],
            'title': project['title'].toString(),
            'projectOwnerID': project['projectOwnerID'].toString(),
            'description': project['description'].toString(),
            'startProject': project['startProject'].toString(),
            'endProject': project['endProject'].toString(),
            'openUntil': project['openUntil'].toString(),
            'totalMember': project['totalMember'].toString(),
            'groupLink': project['groupLink'].toString(),
            'projectStatus': project['projectStatus'].toString(),
            'createdAt': project['createdAt'].toString()
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
            print('Inserting role: ${role['roleID']} ${role['Role']['name']}');

            await txn.insert(
              'Role',
              {
                'roleID': role['roleID'], // Ensure the ID is a String
                'name': role['Role']['name'].toString(),
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
            print(
                'Inserting skill: ${skill['skillID']} ${skill['Skill']['name']}');

            await txn.insert(
              'Skill',
              {
                'skillID': skill['skillID'],
                'name': skill['Skill']['name'].toString(),
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await txn.insert(
              'ProjectSkill',
              {
                'skillID': skill['skillID'],
                'projectID': projectData['projectID'].toString(),
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });

        final List<Future<void>> memberFutures = [];

        for (var member in projectData['ProjectMembers']) {
          memberFutures
              .add(_syncMember(db, client, member, projectData['projectID']));
        }

        await Future.wait(memberFutures);
      }
    } catch (e) {
      print('Error in _syncProject: $e');
    }
  }

  Future<void> _syncMember(
      Database db, http.Client client, dynamic member, int projectId) async {
    try {
      await db.transaction((txn) async {
        print(
            'Inserting project member: ${member['projectMemberID']} ${member['userID']} ${member['roleID']}');

        await txn.insert(
          'ProjectMember',
          {
            'projectMemberID': member['projectMemberID'],
            'userID': member['userID'],
            'roleID': member['roleID'],
            'projectID': projectId.toString(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

      final userResponse =
          await client.get(Uri.parse('$baseUrl/users/${member['userID']}'));
      if (userResponse.statusCode == 200) {
        Map<String, dynamic> user = json.decode(userResponse.body);
        await db.transaction((txn) async {
          print(
              'Inserting user: ${user['userID'].toString()} ${user['firstName']} ${user['lastName']}');

          await txn.insert(
            'users',
            {
              'userID': user['userID'], // Ensure the ID is a String
              'firstName': user['firstName'].toString(),
              'lastName': user['lastName'].toString(),
              'gender': user['gender'].toString(),
              'kelas': user['kelas'].toString(),
              'facultyCode': user['facultyCode'].toString(),
              'majorCode': user['majorCode'].toString(),
              'phoneNumber': user['phoneNumber'].toString(),
              'photoProfileImage': user['photoProfileImage'].toString(),
              'photoProfileUrl': user['photoProfileUrl'].toString(),
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        });
      }
    } catch (e) {
      print('Error in _syncMember: $e');
    }
  }
}

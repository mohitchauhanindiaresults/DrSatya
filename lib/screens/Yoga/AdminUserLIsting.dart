import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:satya_new/screens/Sales/SalesFollowup.dart';

import '../../utils/ApiInterceptor.dart';

class AdminUserLIsting extends StatefulWidget {
  @override
  _AdminUserLIstingState createState() => _AdminUserLIstingState();
}

class _AdminUserLIstingState extends State<AdminUserLIsting> {
  late Future<List<Map<String, dynamic>>> userDetails;
  final Dio _dio = ApiInterceptor.createDio();
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _filteredUsers = [];
  List<Map<String, dynamic>> _allUsers = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'All Leads',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14B3B4), Color(0xFF14B3B4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: userDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading users', style: TextStyle(color: Colors.red, fontSize: 14)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No users found', style: TextStyle(color: Colors.grey, fontSize: 14)));
                  } else {
                    final usersToShow = _isSearching ? _filteredUsers : _allUsers;

                    if (_isSearching && _filteredUsers.isEmpty) {
                      return Center(child: Text('No matching users found', style: TextStyle(color: Colors.white)));
                    }

                    return ListView.builder(
                      itemCount: usersToShow.length,
                      itemBuilder: (context, index) {
                        final user = usersToShow[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12.0),
                              title: Text(
                                user['name'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text('Email: ${user['email']}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  SizedBox(height: 4),
                                  Text('Mobile: ${user['mobile']}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  SizedBox(height: 4),
                                  Text('Password: ${user['password_text']}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  SizedBox(height: 4),
                                  Text('Designation: ${user['designation'].join(', ')}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                              onTap: () {
                                print('Tapped on ${user['name']}');
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchUserDetails() async {
    const userApiEndpoint = 'https://clients.charumindworks.com/satya/api/getAllUsersList';

    try {
      final response = await _dio.get(userApiEndpoint);

      List<Map<String, dynamic>> users = (response.data['AllUsers'] as List)
          .map<Map<String, dynamic>>((user) => {
        'name': user['name'],
        'email': user['email'],
        'mobile': user['mobile'],
        'designation': user['designation'],
        'password_text': user['password_text'],
      })
          .toList();

      setState(() {
        _allUsers = users;
        _filteredUsers = [];
      });

      return users;
    } catch (error) {
      print('Error fetching user data: $error');
      return [];
    }
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      _isSearching = query.isNotEmpty;

      if (query.isEmpty) {
        _filteredUsers = [];
      } else {
        _filteredUsers = _allUsers.where((user) {
          return user['name'].toLowerCase().contains(query) ||
              user['mobile'].toString().contains(query);
        }).toList();
      }
    });
  }
}

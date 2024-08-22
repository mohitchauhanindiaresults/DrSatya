import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AttendanceListing extends StatefulWidget {
  @override
  _AttendanceListingState createState() => _AttendanceListingState();
}

class _AttendanceListingState extends State<AttendanceListing> {
  late Future<Map<String, dynamic>> attendanceDetails;
  String selectedType = '';
  String selectedMode = '';
  String selectedCentre = '';

  @override
  void initState() {
    super.initState();
    attendanceDetails = fetchAttendanceDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Attendance List',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFilterDropdown(
                  title: 'Type',
                  value: selectedType,
                  items: ['new member', 'current member'],
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                      attendanceDetails = fetchAttendanceDetails();
                    });
                  },
                ),
                _buildFilterDropdown(
                  title: 'Mode',
                  value: selectedMode,
                  items: ['online', 'home', 'center'],
                  onChanged: (value) {
                    setState(() {
                      selectedMode = value;
                      attendanceDetails = fetchAttendanceDetails();
                    });
                  },
                ),
                _buildFilterDropdown(
                  title: 'Centre',
                  value: selectedCentre,
                  items: ['sitapura', 'shalimar'],
                  onChanged: (value) {
                    setState(() {
                      selectedCentre = value;
                      attendanceDetails = fetchAttendanceDetails();
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: attendanceDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading data'),
                    );
                  } else {
                    List<dynamic> attendanceList = snapshot.data!['members'];

                    // Debug print to check loaded data
                    print("Loaded attendance data: $attendanceList");

                    // Filter attendanceList based on selected filters
                    attendanceList = attendanceList.where((attendance) {
                      print("Filtering attendance: $attendance"); // Debug print for each attendance
                      return (selectedType.isEmpty || attendance['type'] == selectedType) &&
                          (selectedMode.isEmpty || attendance['mode'] == selectedMode) &&
                          (selectedCentre.isEmpty || attendance['centre'] == selectedCentre);
                    }).toList();

                    // Debug print to check filtered list
                    print("Filtered attendance list: $attendanceList");

                    if (attendanceList.isEmpty) {
                      return Center(
                        child: Text(
                          'No attendance records found for the selected filters.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: attendanceList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> attendance = attendanceList[index];

                        return Column(
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildText('Date', attendance['date']),
                                  _buildText('Type', attendance['type']),
                                  _buildText('Mode', attendance['mode']),
                                  _buildText('Centre', attendance['centre']),
                                  _buildText('Remark', attendance['remark']),
                                  _buildText('Teacher', attendance['teacher']),
                                ],
                              ),
                              onTap: () {
                                // Handle item click
                              },
                            ),
                            Divider(), // Add a divider after each ListTile
                          ],
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

  Widget _buildText(String title, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: TextStyle(color: Colors.white),
        ),
        Flexible(
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text('Select $title', style: TextStyle(color: Colors.white)),
          onChanged: (String? newValue) {
            onChanged(newValue ?? '');
          },
          items: [''].followedBy(items).map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchAttendanceDetails() async {
    const apiEndpoint = 'https://clients.charumindworks.com/satya/api/attendancelist';

    try {
      final response = await Dio().get(apiEndpoint);
      return response.data;
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}

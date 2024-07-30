import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MemberListing extends StatefulWidget {
  @override
  _MemberListingState createState() => _MemberListingState();
}

class _MemberListingState extends State<MemberListing> {
  late Future<Map<String, dynamic>> memberDetails;
  String selectedStatus = '';
  String selectedTrainingMode = '';
  String selectedPackageType = '';

  @override
  void initState() {
    super.initState();
    memberDetails = fetchMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Member List',
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
                  title: 'Status',
                  value: selectedStatus,
                  items: ['New Member', 'Current Member', 'Old Member'],
                  onChanged: (value) => setState(() => selectedStatus = value),
                ),
                _buildFilterDropdown(
                  title: 'Training Mode',
                  value: selectedTrainingMode,
                  items: ['Online', 'Center', 'Both'],
                  onChanged: (value) => setState(() => selectedTrainingMode = value),
                ),
                _buildFilterDropdown(
                  title: 'Package Type',
                  value: selectedPackageType,
                  items: ['Regular', 'Premium', 'Lifetime'],
                  onChanged: (value) => setState(() => selectedPackageType = value),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: memberDetails,
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
                    List<dynamic> memberList = snapshot.data!['members'];

                    // Filter memberList based on selected filters
                    memberList = memberList
                        .where((member) =>
                    (selectedStatus.isEmpty || member['status'] == selectedStatus) &&
                        (selectedTrainingMode.isEmpty || member['training_mode'] == selectedTrainingMode) &&
                        (selectedPackageType.isEmpty || member['package_type'] == selectedPackageType))
                        .toList();

                    if (memberList.isEmpty) {
                      return Center(
                        child: Text(
                          'No members found for the selected filters.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: memberList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> member = memberList[index];

                        return Column(
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildText('First Name', member['first_name']),
                                  _buildText('Last Name', member['last_name']),
                                  _buildText('Mobile', member['mobile']),
                                  _buildText('Alternative Mobile', member['alternative_mobile']),
                                  _buildText('Training Mode', member['training_mode']),
                                  _buildText('Training Type', member['training_type']),
                                  _buildText('Package Type', member['package_type']),
                                  _buildText('Package Start Date', member['package_start_date']),
                                  _buildText('Package End Date', member['package_end_date']),
                                  _buildText('Purpose', member['purpose']),
                                  _buildText('Batch Time', member['batch_time']),
                                  _buildText('Health Issue', member['health_issue']),
                                  _buildText('Extension', member['extension']),
                                  _buildText('Status', member['status']),
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

  Future<Map<String, dynamic>> fetchMemberDetails() async {
    const apiEndpoint = 'https://clients.charumindworks.com/satya/api/memberlist';

    try {
      final response = await Dio().get(apiEndpoint);
      return response.data;
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}

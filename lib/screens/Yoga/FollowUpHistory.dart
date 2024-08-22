import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FollowUpHistory extends StatefulWidget {
  @override
  _FollowUpHistoryState createState() => _FollowUpHistoryState();
}

class _FollowUpHistoryState extends State<FollowUpHistory> {
  late Future<Map<String, dynamic>> followUpDetails;

  @override
  void initState() {
    super.initState();
    followUpDetails = fetchFollowUpDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Follow-Up History',
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
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: followUpDetails,
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
                    List<dynamic> followUpList = snapshot.data!['members'];

                    if (followUpList.isEmpty) {
                      return Center(
                        child: Text(
                          'No follow-up records found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: followUpList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> followUp = followUpList[index];

                        return Column(
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildText('Name', followUp['name']),
                                  _buildText('Mobile', followUp['mobile']),
                                  _buildText('Follow-Up Date', followUp['followup_date']),
                                  _buildText('Follow-Up Time', followUp['followup_time']),
                                  _buildText('Coordinator', followUp['cordinator']),
                                  _buildText('History', followUp['history']),
                                  _buildText('Remark', followUp['remark']),
                                  _buildText('Mode', followUp['mode']),
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

  Future<Map<String, dynamic>> fetchFollowUpDetails() async {
    const apiEndpoint = 'https://clients.charumindworks.com/satya/api/followuplist';

    try {
      final response = await Dio().get(apiEndpoint);
      return response.data;
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}

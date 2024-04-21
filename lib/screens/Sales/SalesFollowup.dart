import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/Utils.dart';

class SalesFollowup extends StatefulWidget {
  final int employeeId;

  SalesFollowup({required this.employeeId});

  @override
  _SalesFollowupState createState() => _SalesFollowupState();
}

class _SalesFollowupState extends State<SalesFollowup> {
  late Future<Map<String, dynamic>> employeeDetails;

  @override
  void initState() {
    super.initState();

    // Initialize the Future in initState
    employeeDetails = initiate(widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Follow Up',
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
            colors: [Color(0xFF14B3B4), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: employeeDetails,
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
              List<dynamic> salesList = snapshot.data!['sales'];

              return ListView.builder(
                itemCount: salesList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> sale = salesList[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //   _buildText('ID', sale['id']),
                            _buildText('Center', sale['center'].toString()),
                            _buildText('Name', sale['name']),
                            _buildText('Mobile', sale['mobile']),
                            _buildText('Alternative', sale['alternative']),
                            //  _buildText('Unique ID', sale['unique_id']),
                            _buildText('Program', sale['program']),
                            _buildText('Sub-program', sale['sub-program']),
                            _buildText(
                                'Initial Remark', sale['intial_remark']),
                            _buildText(
                                'Total Sale', sale['total_sale'].toString()),
                            _buildText('Potentiality', sale['potentiality']),
                            _buildText('Source', sale['source']),
                            _buildText('Assigned To', sale['assigned_to']),
                            _buildText('Status', sale['status']),
                            _buildText('Coordinator', sale['cordinator']),
                            _buildText('Final Remark', sale['final_remark']),
                            //    _buildText('Reports', sale['reports']),
                            //    _buildText('Alerts', sale['alerts']),
                            //    _buildText('Integration', sale['integration']),
                            ////      _buildText('Created By', sale['created_by']),
                            //    _buildText('Created At', sale['created_at']),
                            //    _buildText('Updated At', sale['updated_at']),
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


  Future<Map<String, dynamic>> initiate(int uniqueId) async {
    // Replace the following URL with your actual API endpoint
    const apiEndpoint =
        'https://clients.charumindworks.com/satya/api/salesList';

    try {
      // Make API call using Dio
      final response = await Dio().get(apiEndpoint);
      // Utils.printLongString(response.data);
      print(uniqueId);

      // Filter sales list based on unique_id
      List<dynamic> filteredSales = response.data['sales']
          .where((sale) => sale['unique_id'] == uniqueId.toString())
          .toList();

      // Return the filtered response
      return {
        'status': 'success',
        'message': 'Sales listing successfully.',
        'sales': filteredSales
      };
    } catch (error) {
      // Handle API call errors
      print('Error fetching data: $error');
      throw error; // Rethrow the error to be caught by FutureBuilder
    }
  }
}

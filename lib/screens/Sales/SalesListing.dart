import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:satya_new/screens/Sales/SalesFollowup.dart';

import '../../utils/ApiInterceptor.dart';

class SalesListing extends StatefulWidget {
  @override
  _SalesListingState createState() => _SalesListingState();
}

class _SalesListingState extends State<SalesListing> {
  late Future<Map<String, dynamic>> employeeDetails;
  String selectedStatus = '';
  String selectedPotentiality = '';
  String selectedSource = '';
  final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance

  @override
  void initState() {
    super.initState();

    // Initialize the Future in initState
    employeeDetails = initiate();
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
              children: [
                Text(
                  ' Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Potentiality     ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Source',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  flex: 1, // Ensures it takes up available space
                  child: DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: true, // Ensures it doesn't overflow
                    hint: Text('Select a status'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue ?? '';
                      });
                    },
                    items: <String>['', 'New enquiry', 'Old enquiry', 'Current member', 'Old member']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: selectedPotentiality,
                    isExpanded: true, // Ensures it doesn't overflow

                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPotentiality = newValue ?? '';
                      });
                    },
                    items: <String>['', 'Super Hot', 'Hot', 'Warm', 'Cold']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: selectedSource,
                    isExpanded: true, // Ensures it doesn't overflow

                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSource = newValue ?? '';
                      });
                    },
                    items: <String>['', 'FaceBook', 'Instagram', 'others']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: employeeDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading data'));
                  } else {
                    List<dynamic> salesList = snapshot.data!['sales'];

                    // Filtering logic
                    if (selectedStatus.isNotEmpty) {
                      salesList = salesList
                          .where((sale) => sale['status'] == selectedStatus)
                          .toList();
                    }
                    if (selectedPotentiality.isNotEmpty) {
                      salesList = salesList
                          .where((sale) => sale['potentiality'] == selectedPotentiality)
                          .toList();
                    }
                    if (selectedSource.isNotEmpty) {
                      salesList = salesList
                          .where((sale) => sale['source'] == selectedSource)
                          .toList();
                    }

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
                                  _buildText('Center', sale['center'].toString()),
                                  _buildText('Name', sale['name']),
                                  _buildText('Mobile', sale['mobile']),
                                  _buildText('Alternative', sale['alternative']),
                                  _buildText('Program', sale['program']),
                                  _buildText('Sub-program', sale['sub-program']),
                                  _buildText('Initial Remark', sale['intial_remark']),
                                  _buildText('Total Sale', sale['total_sale'].toString()),
                                  _buildText('Potentiality', sale['potentiality']),
                                  _buildText('Source', sale['source']),
                                  _buildText('Assigned To', sale['assigned_to']),
                                  _buildText('Status', sale['status']),
                                  _buildText('Coordinator', sale['cordinator']),
                                  _buildText('Final Remark', sale['final_remark']),

                                  // Follow Up Button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        onFollowUpPressed(sale);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange, // Button color
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text('Follow Up'),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Handle item click
                                print("Tapped on ${sale['name']}");
                              },
                            ),
                            Divider(),
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

  void onFollowUpPressed(Map<String, dynamic> sale) {
    print('Follow-up clicked for ${sale['name']}');
    Navigator.push(context, MaterialPageRoute(builder: (context) => SalesFollowup(employeeId: 3,)));
  }

  Future<Map<String, dynamic>> initiate() async {
    // Replace the following URL with your actual API endpoint
    const apiEndpoint = 'https://clients.charumindworks.com/satya/api/salesList';

    try {
      // Make API call using Dio
      final response = await _dio.get(apiEndpoint);

      // Filter sales list based on unique_id
      List<dynamic> filteredSales = response.data['sales'].toList();

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

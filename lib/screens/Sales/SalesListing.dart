import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satya_new/screens/Sales/SalesFollowup.dart';
import 'package:satya_new/utils/Utils.dart';

import '../../utils/ApiInterceptor.dart';
import '../Yoga/AddNewFollowUpScreen.dart';

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
  List<Map<String, dynamic>> memberList = [];
  String error = '';
  List<String> programList = [];

  @override
  void initState() {
    super.initState();
    employeeDetails = initiate();
    fetchProgramLis();
  }
  Future<void> fetchProgramLis() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await _dio.get('http://clients.charumindworks.com/satya/api/programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      print("fdfgdfhferdgfefgfgfef"+response.toString());
 //     apiResponse = response.toString();

      //  Utils.saveStringToPrefs(Constant.PROGRAM_API, response.data);
      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        print(coordinatorList);
    //    leadIdController.text= response.data['lead_code'];
        setState(() {
        //  memberList = List<Map<String, dynamic>>.from(coordinatorList.where((element) => element['parent_id'] == null ));
          // filteredMemberList = memberList;
       //   isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            if (coordinator['parent_id'] == null) {
              programList.add(coordinator['name']);
           //   programId.add(coordinator['id']);
            }
          }
        // print("hgcggddfsdfuvgvhh"+programId.toString());
         // print("hgcggddfsdfuvgvhh"+programId.toString());
        });


      } else {
        setState(() {
          error = 'Failed to fetch data. ${responseData['message']}';
       //   isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again.';
     //   isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.80), // Reduce overall scale
          child: Theme(
            data: Theme.of(context).copyWith(
              datePickerTheme: DatePickerThemeData(
                dayStyle: TextStyle(fontSize: 15),
                weekdayStyle: TextStyle(fontSize: 11),
                yearStyle: TextStyle(fontSize: 11),
                headerHeadlineStyle: TextStyle(fontSize: 13),
                headerHelpStyle: TextStyle(fontSize: 10),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        var _dateController = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: const [
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     'Status',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 1,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     'Potentiality',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 1,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     'Source',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 1,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedStatus.isNotEmpty ? selectedStatus : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('Select Program', style: TextStyle(fontSize: 12)),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStatus = newValue ?? '';
                            });
                          },
                          items: programList
                            //  .map((member) => member['status'] as String)
                              .toSet() // remove duplicates
                              .map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Padding Left & Right
                        child: DropdownButtonFormField<String>(
                          value: selectedPotentiality.isNotEmpty ? selectedPotentiality : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('Potentiality',style: TextStyle(fontSize: 12)),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPotentiality = newValue ?? '';
                            });
                          },
                          items: <String>['', 'Super Hot', 'Hot', 'Warm', 'Cold']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.isNotEmpty ? value : 'Select Potentiality',style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
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
                          .where((sale) => sale['program'] == selectedStatus)
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

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name + Mobile Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        sale['name'],
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        sale['mobile'],
                                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Program + Subprogram
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Program: ${sale['program']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Sub Program: ${sale['sub_program']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Potentiality + Source
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Potentiality: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black, // Static part color
                                            ),
                                            children: [
                                              TextSpan(
                                                text: sale['potentiality'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:Utils.getPotentialityColor(sale['potentiality']),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ),
                                      Expanded(
                                        child: Text(
                                          "Source: ${sale['source']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Center and Status
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Center: ${sale['center']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Status: ${sale['status']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Assigned To and Coordinator
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Assigned: ${sale['assigneduser']['name']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Coordinator: ${sale['cordinator']['name']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  // Assigned To and Coordinator
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Lead Status: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black, // Static text color
                                            ),
                                            children: [
                                              TextSpan(
                                                text: sale['followinfo']['status'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Utils.getLeadStatusColor(sale['followinfo']['status']),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      sale['followinfo']['action_status'] != null
                                          ? Expanded(
                                        child: Text(
                                          "Action: ${sale['followinfo']['action_status']}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ) : SizedBox.shrink(),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  sale['followinfo']['initial_datetime'] != null
                                      ? Text(
                                    "Initial Date: ${sale['followinfo']['initial_datetime']}",
                                    style: TextStyle(fontSize: 12),
                                  )
                                      : SizedBox.shrink(),
                                  SizedBox(height: 8),
                                   Text(
                                    "Follow Up Date: ${sale['followinfo']['date']}  ${sale['followinfo']['time']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Remark: ${sale['followinfo']['remark']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 12),

                                  // Follow-up Button
                                  Row(children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                       //   transferLead();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          minimumSize: Size(80, 32), // Smaller width and height
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Internal padding smaller
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          'Transfer lead',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          onFollowUpPressed(sale);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          minimumSize: Size(80, 32), // Smaller width and height
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Internal padding smaller
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          'Follow Up',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],)

                                ],
                              ),
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewFollowUpScreen(salesId: sale['id'].toString(),centerId: sale['center_id'].toString())));
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

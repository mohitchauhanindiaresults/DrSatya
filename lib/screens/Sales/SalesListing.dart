import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:satya_new/screens/Sales/FollowupListScreen.dart';
import 'package:satya_new/utils/Constant.dart';
import 'package:satya_new/utils/Utils.dart';
import '../../utils/ApiInterceptor.dart';
import 'AddNewFollowUpScreen.dart';

class SalesListing extends StatefulWidget {
  @override
  _SalesListingState createState() => _SalesListingState();
}

class _SalesListingState extends State<SalesListing> {
  Future<Map<String, dynamic>>? employeeDetails;
  String selectedStatus = '';
  String selectedPotentiality = '';
  String selectedSource = '';
  final Dio _dio =
      ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance
  List<Map<String, dynamic>> memberList = [];
  String error = '';
  String UserId = '';
  String RoleId = '';
  List<String> programList = [];
  List<String> coordinators = [];
  TextEditingController _searchController = TextEditingController();
  List<dynamic> salesList = [];
  List<dynamic> filteredSalesList = [];

  @override
  void initState() {
    super.initState();
    initiate1();
  }

  Future<void> initiate1() async {
    UserId = (await Utils.getStringFromPrefs(Constant.USER_ID))!;
    RoleId = (await Utils.getStringFromPrefs(
      Constant.ROLL_ID,
    ))!;
    employeeDetails = initiate();
    print(employeeDetails.toString());
    await fetchProgramLis();
    await fetchMemberList();
    filteredSalesList = salesList;
    _searchController.addListener(_filterSales);
  }

  void _filterSales() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      print("object");
      filteredSalesList = salesList.where((sale) {
        String name = sale['name'].toString().toLowerCase();
        print(name);
        return name.contains(query);
      }).toList();
    });
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
                          value:
                              selectedStatus.isNotEmpty ? selectedStatus : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('Select Program',
                              style: TextStyle(fontSize: 12)),
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
                              child:
                                  Text(status, style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        // Padding Left & Right
                        child: DropdownButtonFormField<String>(
                          value: selectedPotentiality.isNotEmpty
                              ? selectedPotentiality
                              : null,
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          hint: Text('Potentiality',
                              style: TextStyle(fontSize: 12)),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPotentiality = newValue ?? '';
                            });
                          },
                          items: <String>[
                            '',
                            'Super Hot',
                            'Hot',
                            'Warm',
                            'Cold'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  value.isNotEmpty
                                      ? value
                                      : 'Select Potentiality',
                                  style: TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40, // Controls the overall height of the search bar
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        labelText: "Search by Name",
                        labelStyle:
                            TextStyle(color: Colors.grey[700], fontSize: 14),
                        prefixIcon: Icon(Icons.search,
                            color: Colors.grey[700], size: 20),
                        filled: true,
                        fillColor: Colors.white,
                        // White background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: employeeDetails == null
                  ? Center(child: Text("No details found"))
                  : FutureBuilder<Map<String, dynamic>>(
                      future: employeeDetails,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error loading data'));
                        } else {
                          salesList = snapshot.data!['sales'];
                          filteredSalesList = List.from(salesList);

// Apply dropdown filters
                          if (selectedStatus.isNotEmpty) {
                            filteredSalesList = filteredSalesList
                                .where((sale) => sale['program'] == selectedStatus)
                                .toList();
                          }
                          if (selectedPotentiality.isNotEmpty) {
                            filteredSalesList = filteredSalesList
                                .where((sale) => sale['potentiality'] == selectedPotentiality)
                                .toList();
                          }
                          if (selectedSource.isNotEmpty) {
                            filteredSalesList = filteredSalesList
                                .where((sale) => sale['source'] == selectedSource)
                                .toList();
                          }

                          String query = _searchController.text.trim().toLowerCase();
                          if (query.isNotEmpty) {
                            filteredSalesList = filteredSalesList.where((sale) {
                              String name = (sale['name'] ?? '').toString().toLowerCase();
                              String mobile = (sale['mobile'] ?? '').toString().toLowerCase();
                              return name.contains(query) || mobile.contains(query);
                            }).toList();
                          }


                          return ListView.builder(
                            itemCount: filteredSalesList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> sale =
                                  filteredSalesList[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    print("object" + sale['id'].toString());

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FollowupListScreen(
                                                saleId: sale['id'].toString()),
                                      ),
                                    );

                                    //  print(sale['id']);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Name + Mobile Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                sale['name'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                sale['mobile'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),

                                          // Program + Subprogram
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Program: ${sale['program']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  "Sub: ${sale['sub_program']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),

                                          // Potentiality + Source
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: "Potentiality: ",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                        text: sale[
                                                                'potentiality'] ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Utils
                                                              .getPotentialityColor(
                                                                  sale[
                                                                      'potentiality']),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  "Source: ${sale['source']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),

                                          // Center and Status
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Center: ${sale['center']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  "Status: ${sale['status']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),

                                          // Assigned To and Coordinator
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Assigned: ${sale['assigneduser']['name']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  "Coordinator: ${sale['cordinator']['name']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Divider(),

                                          // Lead Status + Action
                                          Row(
                                            children: [
                                              // Expanded(
                                              //   child: RichText(
                                              //     text: TextSpan(
                                              //       text: 'Lead Status: ',
                                              //       style: TextStyle(fontSize: 10, color: Colors.black),
                                              //       children: [
                                              //         TextSpan(
                                              //           text: sale['followinfo']['status'] ?? '',
                                              //           style: TextStyle(
                                              //             fontSize: 10,
                                              //             color: Utils.getLeadStatusColor(sale['followinfo']['status']),
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              sale['followinfo']
                                                          ['action_status'] !=
                                                      null
                                                  ? Expanded(
                                                      child: Text(
                                                        "Action: ${sale['followinfo']['action_status']}",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          sale['followinfo']
                                                      ['initial_datetime'] !=
                                                  null
                                              ? Text(
                                                  "Initial: ${sale['followinfo']['initial_datetime']}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(height: 6),
                                          Text(
                                            "Follow Up: ${sale['followinfo']['date']} ${sale['followinfo']['time']}",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            "Remark: ${sale['followinfo']['remark']}",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(height: 8),

                                          // Follow-up Buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  print(sale['id']);
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Select Coordinator"),
                                                        content: SizedBox(
                                                          width:
                                                              double.maxFinite,
                                                          child: memberList
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      memberList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    final coordinator =
                                                                        memberList[
                                                                            index];
                                                                    return ListTile(
                                                                      title: Text(
                                                                          coordinator[
                                                                              'name']),
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "Selected ID: ${coordinator['id']}");
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        trasnfer_lead(
                                                                            context,
                                                                            sale['id'],
                                                                            coordinator['id']);
                                                                      },
                                                                    );
                                                                  },
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                      "No Coordinators Available")),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange,
                                                  minimumSize: Size(70, 28),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Transfer Lead',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {
                                                  onFollowUpPressed(sale);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange,
                                                  minimumSize: Size(70, 28),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 6),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Follow Up',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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

  Future<void> fetchMemberList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await Dio().get(
          'https://clients.charumindworks.com/satya/api/cordinatorAddList');
      Map<String, dynamic> responseData = response.data;
      print(response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['cordinatorList'];
        print(coordinatorList);
        setState(() {
          memberList = List<Map<String, dynamic>>.from(coordinatorList);
          // filteredMemberList = memberList;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            coordinators.add(coordinator['name']);
          }

          // Now 'names' contains the list of names from 'cordinatorList'
          print(names);
        });
      } else {
        setState(() {
          error = 'Failed to fetch data. ${responseData['message']}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again.';
      });
    }
  }

  Future<void> fetchProgramLis() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await _dio.get(
          'http://clients.charumindworks.com/satya/api/programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      print("fdfgdfhferdgfefgfgfef" + response.toString());
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
          programList.add("All");

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
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.80),
          // Reduce overall scale
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNewFollowUpScreen(
                salesId: sale['id'].toString(),
                centerId: sale['center_id'].toString())));
  }

  Future<Map<String, dynamic>> initiate() async {
    // Replace the following URL with your actual API endpoint
    const apiEndpoint =
        'https://clients.charumindworks.com/satya/api/salesList';

    try {
      // Make API call using Dio
      final response = await _dio.get(
        apiEndpoint,
        queryParameters: {
          'user_id': UserId,
          'role_id': RoleId,
        },
      );

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

  Future<void> trasnfer_lead(BuildContext context, lead_id, assign_id) async {
    //   ProgressDialog pd = ProgressDialog(context: context);
    //   pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "lead_id": lead_id,
      "assigned_to": assign_id,
    };
    print(data);
    try {
      final response =
          await dio.post(Constant.BASE_URL + "api/transfer-lead", data: data);
      print("object4e23r");
      print(response);
      if (response.statusCode == 200) {
        //      pd.close(delay: 0);
        //  final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        if (status == "success") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);
          Navigator.of(context).pop(); // Close the dialog
        } else {
          //        pd.close(delay: 0);
          Utils.showAlertDialog(context, "SOMETHING WENT WRONG !!");

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        }
      } else {
        //     pd.close(delay: 0);
        Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        throw Exception('Enquiry failed');
      }
    } catch (e) {
      //   pd.close(delay: 0);
      Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !! $e');
      throw Exception('An error occurred during enquiry');
    }
  }
}

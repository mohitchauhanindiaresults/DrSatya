import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Yoga/AdminUserLIsting.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/ApiInterceptor.dart';
import '../../utils/Constant.dart';
import '../../utils/Utils.dart';

class UpdateMemberScreen extends StatefulWidget {
  final String name;
  final String email;
  final List<String> roles;
  final String mobile;
  final String id;
  final String password;
  final String status;

  const UpdateMemberScreen({
    super.key,
    required this.name,
    required this.email,
    required this.roles,
    required this.mobile,
    required this.id,
    required this.password,
    required this.status,
  });

  @override
  _UpdateMemberScreenState createState() => _UpdateMemberScreenState();
}

class _UpdateMemberScreenState extends State<UpdateMemberScreen> {
  final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance
  // Define a controller for each text field
  TextEditingController roleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passsword = TextEditingController();
  String jsonResponseeee = "";
  String selectedStatus = 'Active'; // default
  List<String> statusOptions = ['ACTIVE', 'INACTIVE'];

  final List<Map<String, String>> options = [
    {"id": "1", "label": "Admin"},
    {"id": "2", "label": "Master Data"},
    {"id": "3", "label": "Sales"},
    {"id": "4", "label": "Billing"},
    {"id": "7", "label": "Yoga"},
    {"id": "16", "label": "Accounts"},
    {"id": "20", "label": "Reports"},
    {"id": "21", "label": "Store"},
  ];
  @override
  void initState() {
    super.initState();
    selectedValues = options
        .where((option) => widget.roles.contains(option['label']))
        .map((option) => option['id']!)
        .toList();
    selectedStatus = widget.status;
    nameController.text = widget.name;
    emailController.text = widget.email;
    mobileController.text = widget.mobile;
    passsword.text = widget.password;

  }
  // Future<void> fetchMemberList() async {
  //   try {
  //     // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
  //     Response response = await Dio().get('https://clients.charumindworks.com/satya/api/cordinatorAddList');
  //     Map<String, dynamic> responseData = response.data;
  //     print( response.data);
  //
  //     if (responseData['status'] == 'false') {
  //       List<dynamic> coordinatorList = responseData['cordinatorList'];
  //       print(coordinatorList);
  //       setState(() {
  //         memberList = List<Map<String, dynamic>>.from(coordinatorList);
  //         // filteredMemberList = memberList;
  //         isLoading = false;
  //
  //         // Extracting names and adding them to a separate list
  //         List<String> names = [];
  //         for (var coordinator in coordinatorList) {
  //           coordinators.add(coordinator['name']);
  //         }
  //
  //         // Now 'names' contains the list of names from 'cordinatorList'
  //         print(names);
  //       });
  //
  //     } else {
  //       setState(() {
  //         error = 'Failed to fetch data. ${responseData['message']}';
  //         isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       error = 'Failed to fetch data. Please try again.';
  //       isLoading = false;
  //     });
  //   }
  // }

  List<String> selectedValues = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Update Data',
          style: TextStyle(
            fontSize: 20, // Adjust the font size
            fontWeight: FontWeight.bold, // Add boldness
            letterSpacing: 1, // Adjust letter spacing
            color: Colors.white, // Text color
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      // Grid view for checkboxes
                      GridView.count(
                        shrinkWrap: true, // Fix the scrollable behavior
                        crossAxisCount: 2, // Two columns in the grid
                        childAspectRatio: 4, // Adjust checkbox size ratio
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: options.map((option) {
                          return CheckboxListTile(
                            title: Text(
                              option["label"]!,
                              style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold), // Adjust the font size as needed
                            ),
                            value: selectedValues.contains(option["id"]),
                            onChanged: (bool? isSelected) {
                              setState(() {
                                if (isSelected == true) {
                                  selectedValues.add(option["id"]!);
                                } else {
                                  selectedValues.remove(option["id"]!);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),

                      SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Status',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                        ),
                        items: statusOptions.map((String status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                      ),

                      SizedBox(height: 15.0),

                      // Name field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),

                      // Mobile field
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),

                      // Password field
                      TextFormField(
                        controller: passsword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),

                // Add Member button
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (nameController.text.isEmpty) {
                      Utils.showAlertDialog(context, "Name field cannot be empty");
                    } else if (selectedValues.isEmpty) {
                      Utils.showAlertDialog(context, "Please select atleast one role");
                    }else if (mobileController.text.isEmpty) {
                      Utils.showAlertDialog(context, "Mobile field cannot be empty");
                    } else if (mobileController.text.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobileController.text)) {
                      Utils.showAlertDialog(context, "Mobile number should be 10 digits");
                    } else if (passsword.text.isEmpty) {
                      Utils.showAlertDialog(context, "Password field cannot be empty");
                    } else if (passsword.text.length <= 6) {
                      Utils.showAlertDialog(context, "Password should be more than 6 characters");
                    }else if (!Utils.isStrongPassword(passsword.text)) {
                      Utils.showAlertDialog(context, "Password should contain special character,number,alphabet & capital letter");
                    }
                    else {
                      updateMember(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14B3B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Update Coordinator',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> updateMember(BuildContext context) async {
    FocusScope.of(context).unfocus(); // 👈 Close keyboard
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");

    final data = {
      "name": nameController.text,
      "mobile": mobileController.text,
      "designation": selectedValues.join(","),
      "role": "9",
      "password": passsword.text,
      "id": widget.id,
      "status": selectedStatus.toString().toUpperCase(),
    };

    print("Request Data: $data");

    try {
      final response = await _dio.post(
        Constant.BASE_URL + "api/updateuser",
        data: data,
      );

      pd.close(delay: 0);
      print("Response Code: ${response.statusCode}");
      print("Response: ${response.toString()}");

      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final String status = jsonResponse['status']?.toString() ?? "";
        final String message = jsonResponse['message']?.toString() ?? "Something went wrong";

        if (status.toLowerCase() == "success") {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminUserLIsting()));
        } else {
          Utils.showAlertDialog(context, message);
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        }
      } else if (response.statusCode == 422) {
        Utils.showAlertDialog(context, "Number already exists");
      } else {
        Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        throw Exception('Update failed');
      }
    } catch (e) {
      pd.close(delay: 0);
      print('Error: $e');

      try {
        final errorResponse = json.decode(jsonResponseeee);
        final String errorMessage = errorResponse['error'] ?? "Unexpected error occurred";
        Utils.showAlertDialog(context, errorMessage);
      } catch (e) {
        Utils.showAlertDialog(context, "Something went wrong.");
      }

      throw Exception('An error occurred during update');
    }
  }

}

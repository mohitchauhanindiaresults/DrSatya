import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/DashboardScreen.dart';
import 'package:satya_new/screens/Yoga/AddAttendanceScreen.dart';
import 'package:satya_new/screens/Yoga/AddFollowupScreen.dart';
import 'package:satya_new/utils/Utils.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'MemberListing.dart';

class AddYogaMemberScreen extends StatefulWidget {
  @override
  _AddYogaMemberScreenState createState() => _AddYogaMemberScreenState();
}

class _AddYogaMemberScreenState extends State<AddYogaMemberScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController trainingModeController = TextEditingController();
  TextEditingController trainingTypeController = TextEditingController();
  TextEditingController packageTypeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController packageValidityController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController batchTimeController = TextEditingController();
  TextEditingController healthIssueController = TextEditingController();
  TextEditingController extensionController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  List<String> trainingModes = ['Online', 'Center', 'Home'];
  List<String> trainingTypes = ['Personal', 'Group'];
  List<String> packageTypes = ['Passes', 'Regular', 'Lifetime'];
  List<String> packageValidity = [
    for (var i = 1; i <= 24; i++) '$i Month${i > 1 ? 's' : ''}'
  ];
  List<String> purposes = [
    'Fitness',
    'Disease',
    'Pain',
    'Weight Loss',
    'Stress',
    'Other'
  ];
  List<String> statuses = [
    'Current Member',
    'Old Member',
    'Default'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Yoga Member',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list), // Use an appropriate icon for your use case
            onPressed: () {
              // Define your action here
              // For example, navigate to the member list screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberListing()), // Replace with your actual member list screen
              );
            },
          ),
        ],
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
                SizedBox(height: 20.0),
                Form(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {

                              Utils.navigateToPage(context, AddAttendanceScreen());

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF14B3B4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              shadowColor: Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                            ),
                            child: Text(
                              'Attendance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ElevatedButton(
                              onPressed: () {

                                Utils.navigateToPage(context, AddFollowupScreen());

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF14B3B4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                shadowColor: Colors.grey,
                                padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                              ),
                              child: Text(
                                'Follow up',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),


                      buildTextFormField(firstNameController, 'First Name'),
                      buildTextFormField(lastNameController, 'Last Name'),
                      buildTextFormField(mobileController, 'Mobile'),
                      buildTextFormField(alternativeMobileController, 'Alternative Mobile'),
                      buildDropdownButtonFormField(trainingModeController, 'Training Mode', trainingModes),
                      buildDropdownButtonFormField(trainingTypeController, 'Training Type', trainingTypes),
                      buildDropdownButtonFormField(packageTypeController, 'Package Type', packageTypes),
                      buildTextFormField(startDateController, 'Start Date'),
                      buildDropdownButtonFormField(packageValidityController, 'Package Validity', packageValidity),
                      buildDropdownButtonFormField(purposeController, 'Purpose of Join', purposes),
                      buildTextFormField(batchTimeController, 'Batch Time'),
                      buildTextFormField(healthIssueController, 'Health Issue'),
                      buildTextFormField(extensionController, 'Extension'),
                      buildDropdownButtonFormField(statusController, 'Status', statuses),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              mobileController.text.isEmpty ||
                              alternativeMobileController.text.isEmpty ||
                              trainingModeController.text.isEmpty ||
                              trainingTypeController.text.isEmpty ||
                              packageTypeController.text.isEmpty ||
                              startDateController.text.isEmpty ||
                              packageValidityController.text.isEmpty ||
                              purposeController.text.isEmpty ||
                              batchTimeController.text.isEmpty ||
                              healthIssueController.text.isEmpty ||
                              extensionController.text.isEmpty ||
                              statusController.text.isEmpty) {
                            Utils.showAlertDialog(context, "Please fill in all fields");
                          } else {
                            addYogaMember(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF14B3B4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          shadowColor: Colors.grey,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                        ),
                        child: Text(
                          'Submit Yoga Member',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButtonFormField(TextEditingController controller, String labelText, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        onChanged: (String? value) {
          setState(() {
            controller.text = value!;
          });
        },
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Future<void> addYogaMember(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    final data = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "mobile": mobileController.text,
      "alternative_mobile": alternativeMobileController.text,
      "training_mode": trainingModeController.text,
      "training_type": trainingTypeController.text,
      "package_type": packageTypeController.text,
      "start_date": startDateController.text,
      "package_validity": packageValidityController.text,
      "purpose": purposeController.text,
      "batch_time": batchTimeController.text,
      "health_issue": healthIssueController.text,
      "extension": extensionController.text,
      "status": statusController.text,
    };
    try {
      final response = await dio.post(
        "https://clients.charumindworks.com/satya/api/addmember",
        data: data,
      );
      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        Map<String, dynamic> responseMap = json.decode(response.toString());
        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();
        if (status == "success") {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        } else {
          pd.close(delay: 0);
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
        pd.close(delay: 0);
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
      pd.close(delay: 0);
      Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!');
      throw Exception('An error occurred during enquiry');
    }
  }
}





import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../model/AssignRightsToRollModel.dart';
import '../model/GetRollByIdModel.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';

class RulesAssign extends StatefulWidget {
  @override
  _RulesAssignState createState() => _RulesAssignState();
}

class _RulesAssignState extends State<RulesAssign> {
  // Define a controller for each text field
  TextEditingController dropdownController = TextEditingController();
  TextEditingController textInputController = TextEditingController();
  bool toggleValue = false;
  bool toggleValue1 = false;
  bool toggleValue2 = false;
  bool toggleValue3 = false;
  bool toggleValue4 = false;
  String jsonResponseeee = "";
  String worksnRight = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Administrator',
          style: TextStyle(
            fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),

                // Dropdown
                DropdownButtonFormField<String>(
                  value: dropdownController.text.isNotEmpty
                      ? dropdownController.text
                      : null,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownController.text = value!;
                    });
                    String valueSelected = "";
                    if ("SuperAdmin" == value) {
                      valueSelected = "1";
                    } else if ("Admin" == value) {
                      valueSelected = "2";
                    } else if ("HR" == value) {
                      valueSelected = "3";
                    } else if ("Doctor" == value) {
                      valueSelected = "4";
                    } else if ("Patient" == value) {
                      valueSelected = "5";
                    } else if ("SalesPerson" == value) {
                      valueSelected = "6";
                    }

                    setState(() {
                      toggleValue = false;
                      toggleValue1 = false;
                      toggleValue2 = false;
                      toggleValue3 = false;
                      toggleValue4 = false;
                    });

                    fetchRuleOfPerticular(value!, context, valueSelected);
                  },
                  items: ['SuperAdmin', 'Admin', 'HR', 'Doctor', 'Patient', 'SalesPerson'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Select Option',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),


                SizedBox(height: 30.0),

                // Toggle Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Member',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      value: toggleValue,
                      onChanged: (bool value) {
                        if (dropdownController.text == "") {
                          Utils.showAlertDialog(
                              context, "Please select dropdown item");
                        } else {
                          String selectedId = "";
                          if (dropdownController.text == "SuperAdmin") {
                            selectedId = "1";
                          }
                          if (dropdownController.text == "Admin") {
                            selectedId = "2";
                          }
                          if (dropdownController.text == "HR") {
                            selectedId = "3";
                          }
                          if (dropdownController.text == "Doctor") {
                            selectedId = "4";
                          }
                          if (dropdownController.text == "Patient") {
                            selectedId = "5";
                          }
                          if (dropdownController.text == "SalesPerson") {
                            selectedId = "6";
                          }
                          String finalWorks="";
                          print(toggleValue);
                          if(!toggleValue){
                             finalWorks = worksnRight + ",1";
                          }else{
                            finalWorks=  worksnRight.replaceAll(",1", '');
                          }

                          AddRules(selectedId, context, finalWorks);

                          setState(() {
                            toggleValue = value;
                          });
                        }
                      },
                      activeColor: Color(0xFF14B3B4),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Member list',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      value: toggleValue1,
                      onChanged: (bool value) {
                        if (dropdownController.text == "") {
                          Utils.showAlertDialog(
                              context, "Please select dropdown item");
                        } else {

                          String selectedId = "";
                          if (dropdownController.text == "SuperAdmin") {
                            selectedId = "1";
                          }
                          if (dropdownController.text == "Admin") {
                            selectedId = "2";
                          }
                          if (dropdownController.text == "HR") {
                            selectedId = "3";
                          }
                          if (dropdownController.text == "Doctor") {
                            selectedId = "4";
                          }
                          if (dropdownController.text == "Patient") {
                            selectedId = "5";
                          }
                          if (dropdownController.text == "SalesPerson") {
                            selectedId = "6";
                          }
                          String finalWorks="";
                          if(!toggleValue1){
                            finalWorks = worksnRight + ",2";
                          }else{
                            finalWorks=  worksnRight.replaceAll(",2", '');
                          }
                          AddRules(selectedId, context, finalWorks);

                          setState(() {
                            toggleValue1 = value;
                          });
                        }
                      },
                      activeColor: Color(0xFF14B3B4),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sales',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      value: toggleValue2,
                      onChanged: (bool value) {
                        if (dropdownController.text == "") {
                          Utils.showAlertDialog(
                              context, "Please select dropdown item");
                        } else {

                          String selectedId = "";
                          if (dropdownController.text == "SuperAdmin") {
                            selectedId = "1";
                          }
                          if (dropdownController.text == "Admin") {
                            selectedId = "2";
                          }
                          if (dropdownController.text == "HR") {
                            selectedId = "3";
                          }
                          if (dropdownController.text == "Doctor") {
                            selectedId = "4";
                          }
                          if (dropdownController.text == "Patient") {
                            selectedId = "5";
                          }
                          if (dropdownController.text == "SalesPerson") {
                            selectedId = "6";
                          }
                          String finalWorks="";
                          if(!toggleValue2){
                            finalWorks = worksnRight + ",3";
                          }else{
                            finalWorks=  worksnRight.replaceAll(",3", '');
                          }
                          AddRules(selectedId, context, finalWorks);

                          setState(() {
                            toggleValue2 = value;
                          });
                        }
                      },
                      activeColor: Color(0xFF14B3B4),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Billing',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      value: toggleValue3,
                      onChanged: (bool value) {
                        if (dropdownController.text == "") {
                          Utils.showAlertDialog(context, "Please select dropdown item");
                        } else {

                          String selectedId = "";
                          if (dropdownController.text == "SuperAdmin") {
                            selectedId = "1";
                          }
                          if (dropdownController.text == "Admin") {
                            selectedId = "2";
                          }
                          if (dropdownController.text == "HR") {
                            selectedId = "3";
                          }
                          if (dropdownController.text == "Doctor") {
                            selectedId = "4";
                          }
                          if (dropdownController.text == "Patient") {
                            selectedId = "5";
                          }
                          if (dropdownController.text == "SalesPerson") {
                            selectedId = "6";
                          }
                          String finalWorks="";
                          if(!toggleValue3){
                            finalWorks = worksnRight + ",4";
                          }else{
                            finalWorks=  worksnRight.replaceAll(",4", '');
                          }
                          AddRules(selectedId, context, finalWorks);

                          setState(() {
                            toggleValue3 = value;
                          });
                        }
                      },
                      activeColor: Color(0xFF14B3B4),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Administration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Switch(
                      value: toggleValue4,
                      onChanged: (bool value) {
                        if (dropdownController.text == "") {
                          Utils.showAlertDialog(
                              context, "Please select dropdown item");
                        } else {
                          String selectedId = "";
                          if (dropdownController.text == "SuperAdmin") {
                            selectedId = "1";
                          }
                          if (dropdownController.text == "Admin") {
                            selectedId = "2";
                          }
                          if (dropdownController.text == "HR") {
                            selectedId = "3";
                          }
                          if (dropdownController.text == "Doctor") {
                            selectedId = "4";
                          }
                          if (dropdownController.text == "Patient") {
                            selectedId = "5";
                          }
                          if (dropdownController.text == "SalesPerson") {
                            selectedId = "6";
                          }
                          String finalWorks="";
                          if(!toggleValue4){
                            finalWorks = worksnRight + ",5";
                          }else{
                            finalWorks =  worksnRight.replaceAll(",5", '');
                          }
                          AddRules(selectedId, context, finalWorks);

                          setState(() {
                            toggleValue4 = value;
                          });
                        }
                      },
                      activeColor: Color(0xFF14B3B4),
                    ),
                  ],
                ),


                SizedBox(height: 30.0),

                // Custom Button

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchRuleOfPerticular(
      String selectedValue, BuildContext context, String id) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    GetRollByIdModel? profileDetails;
    final data = {"Id": id};
    print(data);
    String error = "";
    try {
      final response =
          await dio.post(Constant.BASE_URL + "LoginDs/GetRollById", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());

        profileDetails = GetRollByIdModel.fromJson(responseMap);

        message = profileDetails.message.toString();
        int status = profileDetails.status!.toInt();
        error = profileDetails.error.details.toString();
        print(message);

        if (status == 1) {
          worksnRight="";
          worksnRight = profileDetails.data.data.rolls[0].rollWorkRight;

          if (worksnRight.contains("1")) {
            setState(() {
              toggleValue = true;
            });
          }
          if (worksnRight.contains("2")) {
            setState(() {
              toggleValue1 = true;
            });
          }
          if (worksnRight.contains("3")) {
            setState(() {
              toggleValue2 = true;
            });
          }
          if (worksnRight.contains("4")) {
            setState(() {
              toggleValue3 = true;
            });
          }
          if (worksnRight.contains("5")) {
            setState(() {
              toggleValue4 = true;
            });
          }
        } else {
          pd.close(delay: 0);
          Utils.showAlertDialog(
              context, profileDetails.error!.details.toString());

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
        throw Exception('Login failed');
      }
    } catch (e) {
      print('Error: $e');
      pd.close(delay: 0);
      Map<String, dynamic> response = json.decode(jsonResponseeee);

      // Retrieve the value of the "message" key
      String message = response['message'];

      // Print the result
      print('Message: $message');
      Utils.showAlertDialog(context, message);
      throw Exception('An error occurred during login');
    }
  }

  Future<void> AddRules(
      String selectedId, BuildContext context, String workId) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    AssignRightsToRollModel? profileDetails;
    final data = {"Id": selectedId, "RollWorkRight": workId};
    print(data);
    String error = "";
    try {
      final response = await dio
          .post(Constant.BASE_URL + "LoginDs/AssignRightsToRoll", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());

        profileDetails = AssignRightsToRollModel.fromJson(responseMap);

        message = profileDetails.message.toString();
        int status = profileDetails.status!.toInt();
        error = profileDetails.error.details.toString();
        print(message);

        if (status == 1) {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        } else {
          pd.close(delay: 0);
          Utils.showAlertDialog(
              context, profileDetails.error!.details.toString());

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
        throw Exception('Login failed');
      }
    } catch (e) {
      print('Error: $e');
      pd.close(delay: 0);
      Map<String, dynamic> response = json.decode(jsonResponseeee);

      // Retrieve the value of the "message" key
      String message = response['message'];

      // Print the result
      print('Message: $message');
      Utils.showAlertDialog(context, message);
      throw Exception('An error occurred during login');
    }
  }
}

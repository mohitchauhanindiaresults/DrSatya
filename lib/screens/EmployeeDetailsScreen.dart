import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../model/AddMember.dart';
import '../model/GetEmployeeProfile.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final String employeeId;

  EmployeeDetailsScreen({required this.employeeId});

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late Future<Map<String, dynamic>> employeeDetails;

  @override
  void initState() {
    super.initState();
    // Trigger the API call when the widget is initialized
    initiate();
  }
  TextEditingController roleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController passsword = TextEditingController();
  String jsonResponseeee = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Update Member',
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
                // Title
                SizedBox(height: 50.0),

                // Form
                Form(
                  child: Column(
                    children: [
                      // Dropdown for role
                      // Dropdown for role
                      DropdownButtonFormField<String>(
                        value: roleController.text.isNotEmpty
                            ? roleController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            roleController.text = value!;
                          });
                        },
                        items: [
                          'SuperAdmin', 'Admin', 'HR', 'Doctor', 'Patient', 'SalesPerson'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Role',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      SizedBox(height: 15.0),
                      // Name field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
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
                        // Set the input type to phone

                        decoration: InputDecoration(
                          labelText: 'Mobile',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      // Email field
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      SizedBox(height: 15.0),

                      TextFormField(
                        controller: passsword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
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
                    // Add logic to handle adding a member
                    // For example, you can print the values for now
                    updateMember();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF14B3B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Update Member',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),

                // Add Member button
                ElevatedButton(
                  onPressed: () {
                    // Add logic to handle adding a member
                    // For example, you can print the values for now
                    deleteMember();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE02626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Delete Member',
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

  Future<void> fetchMember(BuildContext context,String employeeId) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    GetEmployeeProfile? profileDetails;
    final data = {
      "employeeid": employeeId,
    };
    print(data);
    String error = "";
    try {
      final response = await dio.post(
          Constant.BASE_URL + "LoginDs/GetEmployeeProfile",
          data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());
        profileDetails = GetEmployeeProfile.fromJson(responseMap);

        message = profileDetails.message.toString();
        int status = profileDetails.status!.toInt();
        error = profileDetails.error.details.toString();
        //     print("098765432"+profileDetails.error.details.toString());
        print(message);

        if (status == 1) {
         roleController.text=profileDetails.data.data.employeeProfiles[0].roll.toString();
         nameController.text=profileDetails.data.data.employeeProfiles[0].name.toString();
         mobileController.text=profileDetails.data.data.employeeProfiles[0].mobile.toString();
         emailController.text=profileDetails.data.data.employeeProfiles[0].email.toString();
         qualificationController.text=profileDetails.data.data.employeeProfiles[0].qualification.toString();
         addressController.text=profileDetails.data.data.employeeProfiles[0].address.toString();
         experienceController.text=profileDetails.data.data.employeeProfiles[0].experience.toString();
         passsword.text=profileDetails.data.data.employeeProfiles[0].password.toString();
         setState(() {

         });



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

  void initiate() {
    Timer(Duration(milliseconds: 50), () {
      fetchMember(context,widget.employeeId);
    });

  }

  Future<void> updateMember() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    AddMember? profileDetails;
    final data = {
      "employeeId": widget.employeeId,
      "email": emailController.text,
      "name": nameController.text,
      "roll": roleController.text,
      "mobile": mobileController.text,
      "password": passsword.text,
    };
    print(data);
    String error = "";
    try {
      final response = await dio.post(
          Constant.BASE_URL + "LoginDs/UpdateEmployeeProfile",
          data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());
        profileDetails = AddMember.fromJson(responseMap);

        message = profileDetails.message.toString();
        String status = profileDetails.status.toString();
        //     print("098765432"+profileDetails.error.details.toString());
        print(message);

        if (status == "success") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

          String selectedId = "";
          if (roleController.text == "SuperAdmin") {
            selectedId = "1";
          }
          if (roleController.text == "Admin") {
            selectedId = "2";
          }
          if (roleController.text == "HR") {
            selectedId = "3";
          }
          if (roleController.text == "Doctor") {
            selectedId = "4";
          }
          if (roleController.text == "Patient") {
            selectedId = "5";
          }
          if (roleController.text == "SalesPerson") {
            selectedId = "6";
          }

          Utils.saveStringToPrefs(Constant.ROLL_ID,selectedId);
          Navigator.pop(context);
        } else {
          pd.close(delay: 0);
          Utils.showAlertDialog(
              context, message);

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


  Future<void> deleteMember() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    AddMember? profileDetails;
    final data = {
      "employeeId": widget.employeeId,

    };
    print(data);
    String error = "";
    try {
      final response = await dio.post(
          Constant.BASE_URL + "LoginDs/DeleteEmployeeProfile",
          data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());
        profileDetails = AddMember.fromJson(responseMap);

        message = profileDetails.message.toString();
        String status = profileDetails.status.toString();
        //     print("098765432"+profileDetails.error.details.toString());
        print(message);

        if (status == "success") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

          Navigator.pop(context);
        } else {
          pd.close(delay: 0);
          Utils.showAlertDialog(
              context, message);

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




import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Sales/SalesListing.dart';
import 'package:satya_new/screens/Sales/SalesSetting.dart';
import 'package:satya_new/screens/Yoga/AdminUserLIsting.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../model/AddMember.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {

  // Define a controller for each text field
  TextEditingController roleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passsword = TextEditingController();
  String jsonResponseeee = "";
  final List<Map<String, String>> options = [
    {"id": "1", "label": "Admin"},
    {"id": "2", "label": "Master Data"},
    {"id": "3", "label": "Sales"},
    {"id": "4", "label": "Billing"},
    {"id": "7", "label": "Yoga"},
    {"id": "16", "label": "Accounts"},
    {"id": "20", "label": "Reports"},
    {"id": "21", "label": "Follow-up"},
  ];
  List<String> selectedValues = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Admin',
          style: TextStyle(
            fontSize: 20, // Adjust the font size
            fontWeight: FontWeight.bold, // Add boldness
            letterSpacing: 1, // Adjust letter spacing
            color: Colors.white, // Text color
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SalesSetting()
                ),
              );
              // Add your settings button functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdminUserLIsting()
                ),
              );
              // Add your settings button functionality here
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
                // Title
             //   SizedBox(height: 50.0),

                // Form
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
                    // Add logic to handle adding a member
                    // For example, you can print the values for now

                  if (nameController.text.isEmpty) {
                      Utils.showAlertDialog(
                          context, "Name field cannot be empty");
                    } else if (mobileController.text.isEmpty) {
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
                      addMember(context);
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
                    'Add Member',
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

  Future<void> addMember(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    // String role="";
    // String designation="";
    // if(roleController.text=="Super Admin"){
    //   role="1";
    //   designation="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
    // }else if(roleController.text=="Center Head"){
    //   role="2";
    //   designation="2,3,4,5,7,8,9,15,17,18,19,21";
    // }else if(roleController.text=="Office Coordinator"){
    //   role="3";
    //   designation="15,17,18,19";
    // }else if(roleController.text=="Receptionist"){
    //   role="4";
    //   designation="2,4,8,12,21";
    //
    // }else if(roleController.text=="Doctor"){
    //   role="5";
    //   designation="6,9,13,14";
    //
    // }else if(roleController.text=="Holistic Counselor"){
    //   role="6";
    //   designation="6,9,10,13,14,21";
    //
    // }else if(roleController.text=="Sales Executive"){
    //   role="7";
    //   designation="2,3,4,5,19,21";
    //
    // }else if(roleController.text=="Yoga Teacher"){
    //   role="8";
    //   designation="7,21";
    //
    // }else if(roleController.text=="Coordinator"){
    //   role="9";
    //   designation="2,3,4,5,19,21";
    //
    // }
   String message = "";

    final Dio dio = Dio();
    AddMember? profileDetails;
    final data = {
      "name": nameController.text,
      "mobile": mobileController.text,
      "designation": selectedValues.join(","),
      "role": "9",
      "password": passsword.text,
    };
    print(data);
    String error = "";
    try {
      final response = await dio.post(Constant.BASE_URL + "api/adduser", data: data);


      print("1234567890"+response.statusCode.toString());
      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        Utils.printLongString(response.toString());
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
              context,message);

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        }
      }else if(response.statusCode == 422){
        Utils.showAlertDialog(context, "Number already exist");
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
      Utils.showAlertDialog(context, "Number already exist");

      Map<String, dynamic> response = json.decode(jsonResponseeee);

      // Retrieve the value of the "message" key
      String message = response['error'];

      // Print the result
      print('Message: $message');
      Utils.showAlertDialog(context, message);
      throw Exception('An error occurred during login');
    }
  }
}

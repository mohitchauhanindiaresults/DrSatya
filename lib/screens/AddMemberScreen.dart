import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Member',
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
                          'Super Admin',
                          'Center Head',
                          'Office Coordinator',
                          'Receptionist',
                          'Doctor',
                          'Holistic Counselor',
                          'Sales Executive',
                          'Yoga Teacher'
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

                    if (roleController.text.isEmpty) {
                      Utils.showAlertDialog(context, "Please select role");
                    } else if (nameController.text.isEmpty) {
                      Utils.showAlertDialog(
                          context, "Name field cannot be empty");
                    } else if (mobileController.text.isEmpty) {
                      Utils.showAlertDialog(
                          context, "Mobile field cannot be empty");
                    } else if (passsword.text.isEmpty) {
                      Utils.showAlertDialog(
                          context, "Password field cannot be empty");
                    } else if (passsword.text.length!=10) {
                      Utils.showAlertDialog(
                          context, "The mobile must be 10 digits.");
                    } else {
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
    String role="";
    String designation="";
    if(roleController.text=="Super Admin"){
      role="1";
      designation="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
    }else if(roleController.text=="Center Head"){
      role="2";
      designation="2,3,4,5,7,8,9,15,17,18,19,21";
    }else if(roleController.text=="Office Coordinator"){
      role="3";
      designation="15,17,18,19";
    }else if(roleController.text=="Receptionist"){
      role="4";
      designation="2,4,8,12,21";

    }else if(roleController.text=="Doctor"){
      role="5";
      designation="6,9,13,14";

    }else if(roleController.text=="Holistic Counselor"){
      role="6";
      designation="6,9,10,13,14,21";

    }else if(roleController.text=="Sales Executive"){
      role="7";
      designation="2,3,4,5,19,21";

    }else if(roleController.text=="Yoga Teacher"){
      role="8";
      designation="7,21";

    }
    String message = "";

    final Dio dio = Dio();
    AddMember? profileDetails;
    final data = {
      "name": nameController.text,
      "mobile": mobileController.text,
      "designation": designation,
      "role": role,
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

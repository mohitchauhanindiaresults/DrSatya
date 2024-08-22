import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/DashboardScreen.dart';
import 'package:satya_new/screens/Yoga/FollowUpHistory.dart';
import 'package:satya_new/utils/Utils.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class AddFollowupScreen extends StatefulWidget {
  @override
  _AddFollowupScreenState createState() => _AddFollowupScreenState();
}

class _AddFollowupScreenState extends State<AddFollowupScreen> {
  TextEditingController followupDateController = TextEditingController();
  TextEditingController followupTimeController = TextEditingController();
  TextEditingController coordinatorController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController historyController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController modeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        followupDateController.text = pickedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        followupTimeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Follow-up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FollowUpHistory()),
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
                      buildDatePickerFormField(
                          followupDateController, 'Follow-up Date', _selectDate),
                      buildTimePickerFormField(
                          followupTimeController, 'Follow-up Time', _selectTime),
                      buildTextFormField(coordinatorController, 'Coordinator'),
                      buildTextFormField(nameController, 'Name'),
                      buildTextFormField(mobileController, 'Mobile'),
                      buildTextFormField(historyController, 'History'),
                      buildTextFormField(remarkController, 'Remark'),
                      buildTextFormField(modeController, 'Mode'),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          if (followupDateController.text.isEmpty ||
                              followupTimeController.text.isEmpty ||
                              coordinatorController.text.isEmpty ||
                              nameController.text.isEmpty ||
                              mobileController.text.isEmpty ||
                              historyController.text.isEmpty ||
                              remarkController.text.isEmpty ||
                              modeController.text.isEmpty) {
                            Utils.showAlertDialog(
                                context, "Please fill in all fields");
                          } else {
                            addFollowup(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF14B3B4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          shadowColor: Colors.grey,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 40.0),
                        ),
                        child: Text(
                          'Submit Follow-up',
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

  Widget buildTextFormField(
      TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget buildDatePickerFormField(
      TextEditingController controller, String labelText, Function selectDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => selectDate(context),
          ),
        ),
      ),
    );
  }

  Widget buildTimePickerFormField(
      TextEditingController controller, String labelText, Function selectTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () => selectTime(context),
          ),
        ),
      ),
    );
  }

  Future<void> addFollowup(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    final Dio dio = Dio();
    final data = {
      "followup_date": followupDateController.text,
      "followup_time": followupTimeController.text,
      "cordinator": coordinatorController.text,
      "name": nameController.text,
      "mobile": mobileController.text,
      "history": historyController.text,
      "remark": remarkController.text,
      "mode": modeController.text,
    };

    try {
      final response = await dio.post(
        "https://clients.charumindworks.com/satya/api/addfollowup",
        data: data,
      );
      pd.close(delay: 0);
      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        Map<String, dynamic> responseMap = json.decode(response.toString());
        String message = responseMap['message'].toString();
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
        Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        throw Exception('Follow-up creation failed');
      }
    } catch (e) {
      pd.close(delay: 0);
      Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!');
      throw Exception('An error occurred during follow-up creation');
    }
  }
}

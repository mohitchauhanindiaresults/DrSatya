import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/Constant.dart';
import '../../utils/Utils.dart';
import '../DashboardScreen.dart';

class ConsultationsForm extends StatefulWidget {
  final int employeeId;

  ConsultationsForm({required this.employeeId});

  @override
  _ConsultationsFormState createState() => _ConsultationsFormState();
}

class _ConsultationsFormState extends State<ConsultationsForm> {
  late Future<Map<String, dynamic>> employeeDetails;

  TextEditingController centerController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController opdNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController presentComplaintsController = TextEditingController();
  TextEditingController pastHistoryController = TextEditingController();
  TextEditingController familyHistoryController = TextEditingController();
  TextEditingController menstrualHistoryController = TextEditingController();
  TextEditingController surgicalHistoryController = TextEditingController();
  TextEditingController investigationsAdvisedController = TextEditingController();
  TextEditingController treatmentAdvisedController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController pulseController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController hrController = TextEditingController();
  TextEditingController tempController = TextEditingController();
  TextEditingController nadiController = TextEditingController();
  TextEditingController digestionController = TextEditingController();
  TextEditingController bowelController = TextEditingController();
  TextEditingController urineController = TextEditingController();
  TextEditingController sleepController = TextEditingController();
  TextEditingController hungerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initaite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Consultation Form',
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
                Form(
                  child: Column(
                    children: [
                      // New input fields
                      TextFormField(
                        controller: centerController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Center',
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
                        controller: firstNameController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'First Name',
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
                        controller: lastNameController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
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
                        controller: mobileController,
                        enabled: false,
                        keyboardType: TextInputType.phone,
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
                        controller: alternativeMobileController,
                        enabled: false,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Alternative Mobile',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      buildTextFormField(opdNoController, 'OPD No.'),

                      buildTextFormField(ageController, 'Age'),
                      buildTextFormField(sexController, 'Sex'),
                      buildTextFormField(addressController, 'Address'),
                      buildTextFormField(bloodGroupController, 'Blood Group'),
                      buildTextFormField(doctorController, 'Doctor'),
                      buildTextFormField(branchController, 'Branch'),
                      buildTextFormField(presentComplaintsController, 'Present Complaints'),
                      buildTextFormField(pastHistoryController, 'Past History'),
                      buildTextFormField(familyHistoryController, 'Family History'),
                      buildTextFormField(menstrualHistoryController, 'Menstrual History'),
                      buildTextFormField(surgicalHistoryController, 'Surgical & Treatment History'),
                      buildTextFormField(investigationsAdvisedController, 'Investigations Advised'),
                      buildTextFormField(treatmentAdvisedController, 'Treatment Advised'),
                      buildTextFormField(heightController, 'Height'),
                      buildTextFormField(weightController, 'Weight'),
                      buildTextFormField(pulseController, 'Pulse'),
                      buildTextFormField(bpController, 'BP'),
                      buildTextFormField(hrController, 'HR'),
                      buildTextFormField(tempController, 'Temp'),
                      buildTextFormField(nadiController, 'NADI'),
                      buildTextFormField(digestionController, 'Digestion'),
                      buildTextFormField(bowelController, 'Bowel'),
                      buildTextFormField(urineController, 'Urine'),
                      buildTextFormField(sleepController, 'Sleep'),
                      buildTextFormField(hungerController, 'Hunger'),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () async {
                          // Add your validation and form submission logic here
                          if (opdNoController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              sexController.text.isEmpty ||
                              presentComplaintsController.text.isEmpty ||
                              pastHistoryController.text.isEmpty ||
                              familyHistoryController.text.isEmpty ||
                              menstrualHistoryController.text.isEmpty ||
                              surgicalHistoryController.text.isEmpty ||
                              investigationsAdvisedController.text.isEmpty ||
                              treatmentAdvisedController.text.isEmpty ||
                              heightController.text.isEmpty ||
                              weightController.text.isEmpty ||
                              pulseController.text.isEmpty ||
                              bpController.text.isEmpty ||
                              hrController.text.isEmpty ||
                              tempController.text.isEmpty ||
                              nadiController.text.isEmpty ||
                              digestionController.text.isEmpty ||
                              bowelController.text.isEmpty ||
                              urineController.text.isEmpty ||
                              sleepController.text.isEmpty ||
                              hungerController.text.isEmpty) {
                            Utils.showAlertDialog(context, "Please fill in all fields");
                          } else {
                            addEnquiry(context);
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
                          'Submit Consultation Form',
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

  Future<void> initaite() async {
    int employeeId = widget.employeeId;
    String? response = await Utils.getStringFromPrefs(Constant.MEMBER_API);

    Utils.printLongString(response! + "1234567890");
    print(employeeId);

    Map<dynamic, dynamic> details = getDetailsById(employeeId, response!);
    // Populate the controllers with data if necessary
    // For now, just an example of filling a few fields:
    centerController.text = details['center'].toString();
    firstNameController.text = details['first_name'].toString();
    lastNameController.text = details['last_name'].toString();
    mobileController.text = details['mobile'].toString();
    alternativeMobileController.text = details['alternative'].toString();

    setState(() {});
  }

  Map<String, dynamic> getDetailsById(int id, String jsonResponseString) {
    try {
      // Print the JSON string before decoding
      Utils.printLongString('JSON Response String: $jsonResponseString');
      String trimmedJson = jsonResponseString.trim();
      Map<String, dynamic> jsonResponse = json.decode(trimmedJson);

      Utils.printLongString(jsonResponse.toString() + "3ew23");

      // Check if 'enquiry' key exists in the response and is a List
      if (jsonResponse.containsKey('enquiry') &&
          jsonResponse['enquiry'] is List) {
        // Find the entry in the 'enquiry' list with the matching 'id'
        var enquiryList = jsonResponse['enquiry'] as List;

        var enquiry = enquiryList.firstWhere(
              (element) => element['id'] == id,
          orElse: () => null,
        );

        // Check if the enquiry with the given id is found
        if (enquiry != null) {
          return {
            'id': enquiry['id'],
            'center': enquiry['center'],
            'first_name': enquiry['first_name'],
            'last_name': enquiry['last_name'],
            'mobile': enquiry['mobile'],
            'alternative': enquiry['alternative'],
            'email': enquiry['email'],
            'country': enquiry['country'],
            'state': enquiry['state'],
            'city': enquiry['city'],
            'address': enquiry['address'],
            'profession': enquiry['profession'],
            'qualification': enquiry['qualification'],
            'age_group': enquiry['age_group'],
            'gender': enquiry['gender'],
            'cordinator': enquiry['cordinator'],
            'source': enquiry['source'],
            'created_by': enquiry['created_by'],
            'created_at': enquiry['created_at'],
            'updated_at': enquiry['updated_at'],
          };
        } else {
          print('Enquiry with id $id not found.');
        }
      } else {
        print('Key "enquiry" is missing or not a List in the JSON response.');
      }
    } catch (e) {
      print('Error decoding JSON: $e');
    }

    // Return an empty map if there was an error or if the id is not found
    return {};
  }

  Future<void> addEnquiry(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "opd_no": opdNoController.text,
      "date": Utils.getCurrentFormattedDate(),
      "time": Utils.getCurrentFormattedTime(),
      "age": ageController.text,
      "sex": sexController.text,
      "name": firstNameController.text,
      "phone": mobileController.text,
      "address": addressController.text,
      "blood_group": bloodGroupController.text,
      "doctor": doctorController.text,
      "branch": branchController.text,
      "present_complaint": presentComplaintsController.text,
      "past_history": pastHistoryController.text,
      "family_history": familyHistoryController.text,
      "menstrual_history": menstrualHistoryController.text,
      "surgical_tratment_history": surgicalHistoryController.text,
      "investigation_advised": investigationsAdvisedController.text,
      "treatment_advised": treatmentAdvisedController.text,
      "height": heightController.text,
      "weight": weightController.text,
      "pulse": pulseController.text,
      "bp": bpController.text,
      "hr": hrController.text,
      "temp": tempController.text,
      "nadi": nadiController.text,
      "digestion": digestionController.text,
      "bowl": bowelController.text,
      "urine": urineController.text,
      "sleep": sleepController.text,
      "hunger": hungerController.text,
    };
    print(data);
    try {
      final response =
      await dio.post(Constant.BASE_URL + "api/addopdInfo", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
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

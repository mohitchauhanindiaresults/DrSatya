import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Sales/SalesFollowup.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/Constant.dart';
import '../../utils/Utils.dart';
import '../DashboardScreen.dart';

class AddBilllingForm extends StatefulWidget {
  final int employeeId;

  AddBilllingForm({required this.employeeId});

  @override
  _AddBilllingFormState createState() => _AddBilllingFormState();
}

class _AddBilllingFormState extends State<AddBilllingForm> {
  late Future<Map<String, dynamic>> employeeDetails;

  TextEditingController centerController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController transectionController = TextEditingController();
  TextEditingController sub_program = TextEditingController();
  TextEditingController packageDetail = TextEditingController();
  TextEditingController treatment = TextEditingController();
  TextEditingController payment_recived = TextEditingController();
  TextEditingController balance = TextEditingController();
  TextEditingController recivedinwords = TextEditingController();
  TextEditingController Validity = TextEditingController();
  TextEditingController Source = TextEditingController();
  TextEditingController Assigned_to = TextEditingController();
  TextEditingController Status = TextEditingController();
  TextEditingController PaymentMode = TextEditingController();
  TextEditingController action = TextEditingController();
  TextEditingController Coordinator = TextEditingController();
  TextEditingController final_remark = TextEditingController();
  String selectedCoordinator = '';
  String Assigned_too = '';
  String programString = '';
  String subprogramString = '';
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];
  bool isLoading = true;
  String error = '';
  String jsonResponseeee = "";
  String apiResponse = "";
  List<String> ageGroups = [];
  List<String> genders = [];
  List<String> sources = [];
  List<String> coordinators = [];
  List<String> programList = [];
  List<String> subprogramList = [];
  List<String> states = [];
  List<String> cities = [];

  @override
  void initState() {
    super.initState();

    initaite();
    transectionController.text = Utils.generateTimestampInMillisecondsLong();
    fetchMemberList();
    fetchProgramLis();
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
          isLoading = false;

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
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again.';
        isLoading = false;
      });
    }
  }

  Future<void> fetchProgramLis() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await Dio().get(
          'https://clients.charumindworks.com/satya/api/programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      print("fdfgdfhferdgfefgfgfef" + response.toString());
      apiResponse = response.toString();

      //  Utils.saveStringToPrefs(Constant.PROGRAM_API, response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        print(coordinatorList);
        setState(() {
          memberList = List<Map<String, dynamic>>.from(
              coordinatorList.where((element) => element['parent_id'] == null));
          // filteredMemberList = memberList;
          isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            if (coordinator['parent_id'] == null) {
              programList.add(coordinator['name']);
            }
          }

          // Now 'names' contains the list of names from 'cordinatorList'
          print("hgcgguvgvhh" + names.toString());
        });
      } else {
        setState(() {
          error = 'Failed to fetch data. ${responseData['message']}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Billing Form',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.access_time),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               SalesFollowup(employeeId: int.parse(centerController.text))
          //       ),
          //     );
          //     // Add your settings button functionality here
          //   },
          // ),
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
                SizedBox(height: 50.0),
                Form(
                  child: Column(
                    children: [
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
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: transectionController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Transection ID',
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
                      DropdownButtonFormField<String>(
                        value: programString.isNotEmpty &&
                                programList.contains(programString)
                            ? programString
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            programString = value ?? '';
                            subprogramList = getNamesWithParentId(apiResponse,
                                getIdFromName(apiResponse, programString));
                            setState(() {});
                            print("gbghbihfjvuhhuhgvbduhsi");
                          });
                        },
                        items: programList
                            .map((country) => DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Program',
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
                      DropdownButtonFormField<String>(
                        value: subprogramString.isNotEmpty &&
                                subprogramList.contains(subprogramString)
                            ? subprogramString
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            subprogramString = value ?? '';

                            print("gbghbihfjvuhhuhgvbduhsi");
                          });
                        },
                        items: subprogramList
                            .map((country) => DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Sub-Program',
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
                        controller: packageDetail,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Package Details',
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
                      DropdownButtonFormField<String>(
                        value: Validity.text.isNotEmpty ? Validity.text : null,
                        onChanged: (String? value) {
                          setState(() {
                            Validity.text = value!;
                          });
                        },
                        items: [
                          '1 Month',
                          '2 Months',
                          '3 Months',
                          '4 Months',
                          '5 Months',
                          '6 Months',
                          '7 Months',
                          '8 Months',
                          '9 Months',
                          '10 Months',
                          '11 Months',
                          '12 Months',
                          '12+ Months'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Validity',
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
                        controller: treatment,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Fill Treatment Fees',
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
                        controller: payment_recived,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Payment Received',
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
                        controller: balance,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Balance Amount',
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
                        controller: recivedinwords,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Received amount in words',
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
                      DropdownButtonFormField<String>(
                        value: PaymentMode.text.isNotEmpty
                            ? PaymentMode.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            PaymentMode.text = value!;
                          });
                        },
                        items: ['Cash', 'UPI', 'Cards', 'Net Banking', 'Other']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Payment Mode',
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
                      DropdownButtonFormField<String>(
                        value: selectedCoordinator.isNotEmpty &&
                                coordinators.contains(selectedCoordinator)
                            ? selectedCoordinator
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCoordinator = value ?? '';

                            print("gbghbihfjvuhhuhgvbduhsi");
                          });
                        },
                        items: coordinators
                            .map((country) => DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Coordinator',
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
                      DropdownButtonFormField<String>(
                        value: Status.text.isNotEmpty ? Status.text : null,
                        onChanged: (String? value) {
                          setState(() {
                            Status.text = value!;
                          });
                        },
                        items: [
                          'New enquiry',
                          'Old enquiry',
                          'Current member',
                          'Old member'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Status',
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
                      DropdownButtonFormField<String>(
                        value: Source.text.isNotEmpty ? Source.text : null,
                        onChanged: (String? value) {
                          setState(() {
                            Source.text = value!;
                          });
                        },
                        items: ['FaceBook', 'Instagram', 'others']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Source',
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
                ElevatedButton(
                  onPressed: () async {
                    if (centerController.text.isEmpty ||
                        firstNameController.text.isEmpty ||
                        lastNameController.text.isEmpty ||
                        mobileController.text.isEmpty) {
                      // Show an error message or handle the validation failure as needed.
                      Utils.showAlertDialog(
                          context, "Please fill in all fields");
                    } else if (mobileController.text.length != 10) {
                      Utils.showAlertDialog(context, "Enter correct mobile !!");
                    } else if (alternativeMobileController.text.length != 10) {
                      Utils.showAlertDialog(context, "Enter correct mobile !!");
                    } else if (mobileController.text ==
                        alternativeMobileController.text) {
                      Utils.showAlertDialog(
                          context, "Numbers cannot be same !!");
                    } else {
                      // All controllers have non-empty text, proceed with addEnquiry.

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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  ),
                  child: Text(
                    'Submit Billing Form',
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
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "mobile": mobileController.text,
      "alternative": alternativeMobileController.text,
      "invoicenumber": transectionController.text,
      "date": getCurrentDate(),
      "program": programString,
      "sub-program": subprogramString,
      "package": packageDetail.text,
      "validity": Validity.text,
      "valid_till": "NA",
      "total_treatment_fee": treatment.text,
      "payemnt_recived_number": payment_recived.text,
      "balance": balance.text,
      "payemnt_recived_words": recivedinwords.text,
      "payment_mode": PaymentMode.text,
      "cordinator": selectedCoordinator,
      "status": Status.text,
      "source": Source.text,
      "terms":"NA",
      "created_by": (await Utils.getStringFromPrefs(Constant.ROLL_ID))

    };
    print(data);
    try {
      final response =
          await dio.post(Constant.BASE_URL + "api/addBilling", data: data);

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

  Future<void> initaite() async {
    int employeeId = widget.employeeId;
    String? response = await Utils.getStringFromPrefs(Constant.MEMBER_API);

    Utils.printLongString(response! + "1234567890");
    print(employeeId);

    Map<dynamic, dynamic> details = getDetailsById(employeeId, response!);
    centerController.text = details['center'].toString();
    firstNameController.text = details['first_name'].toString();
    lastNameController.text = details['last_name'].toString();
    mobileController.text = details['mobile'].toString();
    alternativeMobileController.text = details['alternative'].toString();

    setState(() {});
  }

  bool isMobileNumberFound(String jsonResponse, String mobileNumber) {
    try {
      // Parse the JSON string
      Map<String, dynamic> responseMap = json.decode(jsonResponse);

      // Check if "enquiry" key exists and is a list
      if (responseMap.containsKey('enquiry') &&
          responseMap['enquiry'] is List) {
        // Iterate through the list of enquiries
        for (var enquiry in responseMap['enquiry']) {
          // Check if mobile or alternative mobile matches the provided number
          if (enquiry['mobile'] == mobileNumber ||
              enquiry['alternative'] == mobileNumber) {
            return true; // Number found
          }
        }
      }

      // If the loop completes without finding the number, return false
      return false;
    } catch (e) {
      // Handle any parsing errors
      print('Error parsing JSON: $e');
      return false;
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
    return formattedDate;
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';
    return formattedTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    } else {
      return '0$n';
    }
  }

  List<String> getNamesWithParentId(String responseString, int parentId) {
    List<Map<String, dynamic>> response =
        (json.decode(responseString)['programList'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
    List<String> names = [];
    for (var item in response) {
      if (item['parent_id'] == parentId) {
        names.add(item['name']);
      }
    }
    return names;
  }

  int getIdFromName(String responseString, String name) {
    List<Map<String, dynamic>> response =
        (json.decode(responseString)['programList'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
    for (var item in response) {
      if (item['name'] == name) {
        return item['id'];
      }
    }
    return 0; // Return null if the name is not found
  }
}

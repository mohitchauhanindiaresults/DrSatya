import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Sales/SalesFollowup.dart';
import 'package:satya_new/screens/Sales/SalesListing.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/ApiInterceptor.dart';
import '../../utils/Constant.dart';
import '../../utils/Utils.dart';
import '../DashboardScreen.dart';

class AddSaleForm extends StatefulWidget {
  final int employeeId;

  AddSaleForm({required this.employeeId});

  @override
  _AddSaleFormState createState() => _AddSaleFormState();
}

class _AddSaleFormState extends State<AddSaleForm> {
  late Future<Map<String, dynamic>> employeeDetails;

  TextEditingController centerController = TextEditingController();
  TextEditingController leadIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController sub_program = TextEditingController();
  TextEditingController intial_remark = TextEditingController();
  TextEditingController Expected_sale = TextEditingController();
  TextEditingController Potentiality = TextEditingController();
  TextEditingController Source = TextEditingController();
  TextEditingController Assigned_to = TextEditingController();
  TextEditingController Status = TextEditingController();
  TextEditingController action = TextEditingController();
  TextEditingController Coordinator = TextEditingController();
  TextEditingController final_remark = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController followUpRemarksController = TextEditingController();

  String selectedCoordinator = '';
  String Assigned_too = '';
  String selectedAssigned_toId = '';
  String programString = '';
  String subprogramString = '';
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];
  bool isLoading = true;
  String error = '';
  String jsonResponseeee = "";
  String apiResponse = "";
  String centerId = "";
  List<String> ageGroups = [];
  List<String> genders = [];
  List<String> sources = [];
  List<String> coordinators = [];
  List<int> coordinatorsId = [];
  String selectedCoordinatorId = "";
  List<String> programList = [];
  List<int> programId = [];
  String selectedProgramId ='';
  String selectedSubProgramId ='';
  List<String> subprogramList = [];
  List<String> subprogramId = [];
  List<String> states = [];
  List<String> cities = [];
  final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance
  @override
  void initState() {
    super.initState();

    initaite();
    fetchMemberList();
    fetchProgramLis();
  }
  Future<void> fetchMemberList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await _dio.get('https://clients.charumindworks.com/satya/api/cordinatorAddList');
      Map<String, dynamic> responseData = response.data;
      print( response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['cordinatorList'];
        setState(() {
          memberList = List<Map<String, dynamic>>.from(coordinatorList);
         // filteredMemberList = memberList;
          isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];

          for (var coordinator in coordinatorList) {
            coordinators.add(coordinator['name']);
            coordinatorsId.add(coordinator['id']);
          }

          // Now 'names' contains the list of names from 'cordinatorList'

        });
        setState(() {

        });
        print("sdsdsd"+coordinatorsId.toString());
        print("sdsasasßdsd"+coordinators.toString());
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
      Response response = await _dio.get('http://clients.charumindworks.com/satya/api/programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      print("fdfgdfhferdgfefgfgfef"+response.toString());
      apiResponse = response.toString();

     //  Utils.saveStringToPrefs(Constant.PROGRAM_API, response.data);
      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        print(coordinatorList);
        leadIdController.text= response.data['lead_code'];
        setState(() {
          memberList = List<Map<String, dynamic>>.from(coordinatorList.where((element) => element['parent_id'] == null ));
         // filteredMemberList = memberList;
          isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            if (coordinator['parent_id'] == null) {
              programList.add(coordinator['name']);
              programId.add(coordinator['id']);
            }
          }
          print("hgcggddfsdfuvgvhh"+programId.toString());
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
          'Create Lead',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.access_time),
        //     onPressed: () {
        //       // Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(
        //       //       builder: (context) =>
        //       //           SalesFollowup(employeeId: int.parse(centerController.text))
        //       //   ),
        //       // );
        //       // Add your settings button functionality here
        //     },
        //   ),
        //
        // ],
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
                        controller: leadIdController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Lead No.',
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
                        controller: centerController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText:'Center',
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
                          labelText: 'Mobile Number',
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
                          labelText: 'Alternate Mobile Number',
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
                        value: programString.isNotEmpty && programList.contains(programString)
                            ? programString
                            : null,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              programString = value;
                              // Update subprogramList based on selected program
                              subprogramList = getNamesWithParentId(apiResponse, getIdFromName(apiResponse, programString));
                              // Update selectedProgramId
                              int selectedIndex = programList.indexOf(programString);
                              if (selectedIndex != -1 && selectedIndex < programId.length) {
                                selectedProgramId = programId[selectedIndex].toString();
                                print("fdfdfd"+selectedProgramId.toString());
                              } else {
                                selectedProgramId = '';
                              }
                              // Also reset subprogram selection when program changes
                              subprogramString = '';
                              selectedSubProgramId = '';
                            });
                          }
                        },
                        items: programList.map((program) => DropdownMenuItem<String>(
                          value: program,
                          child: Text(program),
                        )).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Program',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      SizedBox(height: 15.0),

                      DropdownButtonFormField<String>(
                        value: subprogramString.isNotEmpty && subprogramList.contains(subprogramString)
                            ? subprogramString
                            : null,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              subprogramString = value;

                              // Update selectedSubProgramId
                              // int selectedIndex = subprogramList.indexOf(subprogramString);
                              // if (selectedIndex != -1 && selectedIndex < subprogramId.length) {
                                selectedSubProgramId = getIdFromName(apiResponse, subprogramString).toString();
                                print("object"+selectedSubProgramId.toString());
                              // } else {
                              //   selectedSubProgramId = '';
                              // }
                            });
                          }
                        },
                        items: subprogramList.map((subProgram) => DropdownMenuItem<String>(
                          value: subProgram,
                          child: Text(subProgram),
                        )).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Sub-Program',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        controller: intial_remark,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Initial Remark',
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
                      // TextFormField(
                      //   controller: Expected_sale,
                      //   keyboardType: TextInputType.phone,
                      //   decoration: InputDecoration(
                      //     labelText: 'Expected Sale',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: Potentiality.text.isNotEmpty
                            ? Potentiality.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            Potentiality.text = value!;
                          });
                        },
                        items: ['Super Hot', 'Hot', 'Warm', 'Cold']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Potentiality',
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
                      SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: Assigned_too.isNotEmpty &&
                            coordinators.contains(Assigned_too)
                            ? Assigned_too
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            Assigned_too = value ?? '';
                            // print("gbghbihfjvuhhuhgvbduhsi");
                            // print("sdsdsd"+coordinatorsId.toString());
                            // print("sdsasasßdsd"+coordinators.toString());
                            var selectedIndex =coordinators.indexOf(Assigned_too);
                            selectedAssigned_toId= coordinatorsId.elementAt(selectedIndex).toString();
                            // print("object"+selectedAssigned_toId+ "dsfdsf"+ Assigned_too);
                          });
                        },
                        items: coordinators
                            .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Assigned To',
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
                        items: ['New enquiry', 'Old enquiry','Current member','Old member'].map((String value) {
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
                        value: selectedCoordinator.isNotEmpty &&
                            coordinators.contains(selectedCoordinator)
                            ? selectedCoordinator
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCoordinator = value ?? '';
                            print("gbghbihfjvuhhuhgvbduhsi");
                            print("sdsdsd"+coordinatorsId.toString());
                            print("sdsasasßdsd"+coordinators.toString());
                            var selectedIndex =coordinators.indexOf(selectedCoordinator);
                             selectedCoordinatorId=   coordinatorsId.elementAt(selectedIndex).toString();
                            print("object"+selectedCoordinatorId);
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
                      // DropdownButtonFormField<String>(
                      //   value: action.text.isNotEmpty ? action.text : null,
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       action.text = value!;
                      //     });
                      //   },
                      //   items: [
                      //     'Billing',
                      //     'Follow-up',
                      //     'Not-interested',
                      //   ].map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: 'Select Action',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      // TextFormField(
                      //   controller: final_remark,
                      //   keyboardType: TextInputType.text,
                      //   decoration: InputDecoration(
                      //     labelText: 'Final Remark',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
            onPressed: () async {
                    if (programString.isEmpty ||
                        subprogramString.isEmpty ||
                        intial_remark.text.isEmpty ||
                        Source.text.isEmpty ||
                        Assigned_too.isEmpty ||
                        Status.text.isEmpty ||
                        selectedCoordinator.isEmpty ||
                        Potentiality.text.isEmpty) {
                      // Show an error message or handle the validation failure as needed.
                      Utils.showAlertDialog(context, "Please fill in all fields");
                    }
                    // else if (mobileController.text.length != 10) {
                    //   Utils.showAlertDialog(context, "Enter correct mobile !!");
                    // } else if (alternativeMobileController.text.length != 10) {
                    //   Utils.showAlertDialog(context, "Enter correct mobile !!");
                    // } else if (mobileController.text == alternativeMobileController.text) {
                    //   Utils.showAlertDialog(context, "Numbers cannot be same !!");
                    // }
                    else {
                      // All controllers have non-empty text, proceed with addEnquiry.

                      showCreateDialog(context);
                      // addEnquiry(context);
                    }
                    // addEnquiry(context);
                    // showUpdateCenterDialog(context,"1");
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
                    'Create Lead',
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
            'center_id': enquiry['center_id'],
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


  // Future<void> addEnquiry() async {
  //   if (programString.isEmpty ||
  //       subprogramString.isEmpty ||
  //       intial_remark.text.isEmpty ||
  //       Source.text.isEmpty ||
  //       Assigned_too.isEmpty ||
  //       Status.text.isEmpty ||
  //       selectedCoordinator.isEmpty ||
  //       dateController.text.isEmpty ||
  //       timeController.text.isEmpty ||
  //       followUpRemarksController.text.isEmpty ||
  //       Potentiality.text.isEmpty) {
  //     // Show an error message or handle the validation failure as needed.
  //     Utils.showAlertDialog(context, "Please fill in all fields");
  //     return;
  //   }
  //   // ProgressDialog pd = ProgressDialog(context : context);
  //   // pd.show(msg: "Please Wait");
  //   setState(() => isLoading = true);
  //   String message = "";
  //   final Dio dio = Dio();
  //   // Adjust the API endpoint accordingly
  //   final data = {
  //     "name": firstNameController.text,
  //     "mobile": mobileController.text,
  //     "alternative": alternativeMobileController.text,
  //     "center_id":  centerId,
  //     "center": centerController.text,
  //     // "unique_id": Utils.generateTimestampInMilliseconds(),
  //     "program": programString,
  //     "sub_program": subprogramString,
  //     "intial_remark": intial_remark.text,
  //     "total_sale":"800",
  //     "potentiality": Potentiality.text,
  //     "source": Source.text,
  //     "assigned_to": Assigned_too,
  //     "status": Status.text,
  //     "cordinator": selectedCoordinator,
  //     // "final_remark": final_remark.text,
  //     "followup_date": dateController.text.toString().trim(),
  //     "followup_time": timeController.text.toString().trim(),
  //     "remark": followUpRemarksController.text.toString().trim(),
  //     "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
  //     "reports": action.text,
  //     "alerts": "0",
  //     "reports": "0",
  //   };
  //   print(data);
  //   try {
  //     final response = await _dio.post(Constant.BASE_URL + "api/addesales", data: data);
  //
  //     if (response.statusCode == 200) {
  //       // pd.close(delay: 0);
  //       final jsonResponse = response.data;
  //       print(response.toString());
  //
  //       Map<String, dynamic> responseMap = json.decode(response.toString());
  //
  //       // You may need to create a model class for the API response
  //       // For example, if it's similar to the AddMember class, you can use it here
  //
  //       message = responseMap['message'].toString();
  //       String status = responseMap['status'].toString();
  //
  //       if (status == "success") {
  //         Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => DashboardScreen(),
  //           ),
  //         );
  //       } else {
  //         // pd.close(delay: 0);
  //         Utils.showAlertDialog(context, "SOMETHING WENT WRONG !!");
  //         Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white,);
  //       }
  //     } else {
  //       // pd.close(delay: 0);
  //       Fluttertoast.showToast(
  //         msg: "Internal Server Error",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.grey,
  //         textColor: Colors.white,
  //       );
  //       throw Exception('Enquiry failed');
  //     }
  //   } catch (e) {
  //     // pd.close(delay: 0);
  //     Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!');
  //     throw Exception('An error occurred during enquiry');
  //   }
  // }

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
    centerId=details['center_id'].toString();
    alternativeMobileController.text = details['alternative'] != null ?details['alternative'].toString():'';

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
    List<Map<String, dynamic>> response = (json.decode(responseString)['programList'] as List)
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
    List<Map<String, dynamic>> response = (json.decode(responseString)['programList'] as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
    for (var item in response) {
      if (item['name'] == name) {
        return item['id'];
      }
    }
    return 0; // Return null if the name is not found
  }
  Future<void> showCreateDialog(BuildContext context,) async {
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> pickDate() async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                dateController.text = picked.toLocal().toString().split(' ')[0];
              }
            }

            Future<void> pickTime() async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                final now = DateTime.now();
                final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
                timeController.text = TimeOfDay.fromDateTime(dt).format(context);
              }
            }

            Future<void> addEnquiry() async {
              setState(() => isLoading = true);
              if (programString.isEmpty ||
                  subprogramString.isEmpty ||
                  intial_remark.text.isEmpty ||
                  Source.text.isEmpty ||
                  Assigned_too.isEmpty ||
                  Status.text.isEmpty ||
                  selectedCoordinator.isEmpty ||
                  dateController.text.isEmpty ||
                  timeController.text.isEmpty ||
                  followUpRemarksController.text.isEmpty ||
                  Potentiality.text.isEmpty) {
                // Show an error message or handle the validation failure as needed.
                Utils.showAlertDialog(context, "Please fill in all fields");
                return;
              }
              // ProgressDialog pd = ProgressDialog(context: context);
              // pd.show(msg: "Please Wait");
              setState(() => isLoading = true);
              String message = "";
              final Dio dio = Dio();
              // Adjust the API endpoint accordingly
              final data = {
                "name": firstNameController.text,
                "mobile": mobileController.text,
                "alternative": alternativeMobileController.text,
                "center_id":  centerId,
                "center": centerController.text,
                "lead_no": leadIdController.text.toString().trim(),
                "program": programString,
                "sub_program": subprogramString,
                "program_id": selectedProgramId.toString(),
                "sub_program_id": selectedSubProgramId.toString(),
                "intial_remark": intial_remark.text,
                "total_sale":"800",
                "potentiality": Potentiality.text,
                "source": Source.text,
                "assigned_to": selectedAssigned_toId,
                "status": Status.text,
                "cordinator": selectedCoordinatorId,
                // "final_remark": final_remark.text,
                "followup_date": dateController.text.toString().trim(),
                "followup_time": timeController.text.toString().trim(),
                "remark": followUpRemarksController.text.toString().trim(),
                "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
                "reports": action.text,
                "alerts": "0",
                "reports": "0",
              };
              print(data);
              try {

                final response = await _dio.post(Constant.BASE_URL + "api/addesales", data: data);
                if (response.statusCode == 200) {
                  // pd.close(delay: 0);
                  final jsonResponse = response.data;
                  print(response.toString());
                  Map<String, dynamic> responseMap = json.decode(response.toString());
                  message = responseMap['message'].toString();
                  String status = responseMap['status'].toString();
                  if (status == "success") {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalesListing(),
                      ),
                    );
                  } else {
                    // pd.close(delay: 0);
                    Utils.showAlertDialog(context, "SOMETHING WENT WRONG !!");
                    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white,);
                  }
                } else {
                  // pd.close(delay: 0);
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
                // pd.close(delay: 0);
                Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!');
                throw Exception('An error occurred during enquiry');
              } finally {
                setState(() => isLoading = false);
              }
            }

            return AlertDialog(
              title: Text('Follow Up'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(labelText: 'Select Date'),
                      onTap: pickDate,
                    ),
                    TextField(
                      controller: timeController,
                      readOnly: true,
                      decoration: InputDecoration(labelText: 'Select Time'),
                      onTap: pickTime,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        controller: followUpRemarksController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Final Remarks',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : () => addEnquiry(),
                  child: isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}

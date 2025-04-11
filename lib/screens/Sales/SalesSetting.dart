import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Sales/AddSaleForm.dart';
import 'package:satya_new/screens/SubProgramScreen.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/ApiInterceptor.dart';
import '../../utils/Constant.dart';
import '../../utils/Utils.dart';

class SalesSetting extends StatefulWidget {
  @override
  _SalesSettingState createState() => _SalesSettingState();
}

class _SalesSettingState extends State<SalesSetting> {
  TextEditingController coordinatorController = TextEditingController();
  TextEditingController coordinatorControllerp = TextEditingController();
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];
  List<Map<String, dynamic>> programList = [];
  List<Map<String, dynamic>> filteredProgramList = [];
  bool isLoading = true;
  bool isLoadingp = true;
  String error = '';
  String programString = '';
  String jsonResponseeee = "";
  String apiResponse = "";
  List<String> subprogramList = [];
  final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance

  @override
  void initState() {
    super.initState();
 //   fetchMemberList(); // Call the method to fetch the member list
    fetchProgramList();
    fetchSubProgramList();
  }

  // Method to fetch member list from API
  Future<void> fetchMemberList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await _dio.get('${Constant.BASE_URL_2}cordinatorAddList');
      Map<String, dynamic> responseData = response.data;
      print( response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['cordinatorList'];
        print(coordinatorList);
        setState(() {
          memberList = List<Map<String, dynamic>>.from(coordinatorList);
          filteredMemberList = memberList;
          isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            names.add(coordinator['name']);
          }

          // Now 'names' contains the list of names from 'cordinatorList'122
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

  Future<void> fetchProgramList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await _dio.get('${Constant.BASE_URL_2}programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      // print(response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        // print("bfggrfhgbf" + coordinatorList.toString());
        setState(() {
          // Filter and retrieve only yoga programs with a null parent ID
          programList = List<Map<String, dynamic>>.from(coordinatorList.where((element) => element['parent_id'] == null ));
          filteredProgramList = programList;
          isLoadingp = false;
          print("uuyiyu"+programList.toString());
          print("uuyidfdffyu"+filteredProgramList.toString());
          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            if (coordinator['parent_id'] == null) {
              names.add(coordinator['name']);
            }
          }

          // Now 'names' contains the list of names from 'cordinatorList'
          print(names);
        });
      } else {
        setState(() {
          error = 'Failed to fetch data. ${responseData['message']}';
          isLoadingp = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again.';
        isLoadingp = false;
      });
    }
  }

  Future<void> fetchSubProgramList() async {
    try {
      final response = await _dio.get(
        Constant.BASE_URL_2+Constant.FETCH_SUBPROGRAM,
        options: Options(
          headers: {
            'Content-Type': 'application/json',  // Add necessary headers
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Success: ${response.data}');
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),

            // // Coordinator Section
            // Center(
            //   child: Text(
            //     'Coordinator names',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       letterSpacing: 1,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            //
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: coordinatorController,
            //           decoration: InputDecoration(
            //             hintText: 'Fill Coordinator',
            //           ),
            //           onChanged: (query) {
            //             filterMemberList(query);
            //           },
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       ElevatedButton(
            //         onPressed: () {
            //           if (coordinatorController.text.isEmpty) {
            //             Utils.showAlertDialog(context, "Text box cannot be empty");
            //           } else {
            //             AddApi(context, coordinatorController.text);
            //           }
            //         },
            //         child: Text('Add'),
            //       ),
            //     ],
            //   ),
            // ),
            //
            // isLoadingp
            //     ? Center(child: CircularProgressIndicator())
            //     : error.isNotEmpty
            //     ? Center(child: Text(error))
            //     : SizedBox(
            //   height: 200,  // Set a fixed height for the ListView
            //   child: ListView.builder(
            //     itemCount: filteredMemberList.length,
            //     itemBuilder: (context, index) {
            //       final member = filteredMemberList[index];
            //       return ListTile(
            //         title: Text(' ${member['name']}'),
            //         subtitle: member['alternative'] != null
            //             ? Text('Alternative: ${member['alternative']}')
            //             : null,
            //         trailing: IconButton(
            //           icon: Icon(Icons.delete, color: Colors.red),
            //           onPressed: () {
            //             print(member['name']);
            //             deleteApi(context, member['name']);
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),

            SizedBox(height: 15.0),

            // Programs Section
            Center(
              child: Text(
                'Programs',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Note : To add subprograms, click on the Programs section and click to proceed.',
                  style: TextStyle(
                    fontSize: 14,
                //    fontWeight: FontWeight.bold,
                             //     letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: coordinatorControllerp,
                      decoration: InputDecoration(
                        hintText: 'Fill Program',
                      ),
                      onChanged: (query) {
                        filterMemberListp(query);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (coordinatorControllerp.text.isEmpty) {
                        Utils.showAlertDialog(context, "Text box cannot be empty");
                      } else {
                        AddApiProgram(context, coordinatorControllerp.text);
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),

            isLoadingp
                ? Center(child: CircularProgressIndicator())
                : error.isNotEmpty
                ? Center(child: Text(error))
                : SizedBox(
              height: 200,  // Set a fixed height for the ListView
              child: ListView.builder(
                itemCount: filteredProgramList.length,
                itemBuilder: (context, index) {
                  final program = filteredProgramList[index];
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        print("Clicked on: ${program['name']}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubProgramScreen(
                              employeeId: program['id'],
                            ),
                          ),
                        );
                      },
                      child: Text(' ${program['name']}'),
                    ),
                    subtitle: program['alternative'] != null
                        ? Text('Alternative: ${program['alternative']}')
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        print(program['name']);
                        deleteApiProgram(context, program['name']);
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 15.0),

            // Sub Program Section
            // Center(
            //   child: Text(
            //     'Sub Program',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       letterSpacing: 1,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 15.0),
            // DropdownButtonFormField<String>(
            //   padding: const EdgeInsets.only(
            //     left: 15.0,
            //     right: 15.0,
            //   ),
            //   value: programString.isNotEmpty &&
            //       programList.any((item) => item['name'] == programString)
            //       ? programString
            //       : null,
            //   onChanged: (String? value) {
            //     setState(() {
            //       programString = value ?? '';
            //       subprogramList = getNamesWithParentId(
            //           apiResponse,
            //           getIdFromName(apiResponse, programString)
            //       );
            //     });
            //   },
            //   items: programList.map((item) => DropdownMenuItem<String>(
            //     value: item['name'].toString(),
            //     child: Text(item['name'].toString()),
            //   )).toList(),
            //   decoration: InputDecoration(
            //     labelText: 'Select Program',
            //     filled: true,
            //     // fillColor: Colors.white,
            //     contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
            //     // border: OutlineInputBorder(
            //     //   borderRadius: BorderRadius.circular(10.0),
            //     // ),
            //   ),
            // ),
            // // SizedBox(height: 15.0),
            //
            //
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: coordinatorControllerp,
            //           decoration: InputDecoration(
            //             hintText: 'Fill Sub Program',
            //           ),
            //           onChanged: (query) {
            //             filterMemberListp(query);
            //           },
            //         ),
            //       ),
            //       SizedBox(width: 10),
            //       ElevatedButton(
            //         onPressed: () {
            //           if (coordinatorControllerp.text.isEmpty) {
            //             Utils.showAlertDialog(context, "Text box cannot be empty");
            //           } else {
            //             AddApiProgram(context, coordinatorControllerp.text);
            //           }
            //         },
            //         child: Text('Add'),
            //       ),
            //     ],
            //   ),
            // ),
            //
            // isLoadingp
            //     ? Center(child: CircularProgressIndicator())
            //     : error.isNotEmpty
            //     ? Center(child: Text(error))
            //     : SizedBox(
            //   height: 200,  // Set a fixed height for the ListView
            //   child: ListView.builder(
            //     itemCount: filteredProgramList.length,
            //     itemBuilder: (context, index) {
            //       final program = filteredProgramList[index];
            //       return ListTile(
            //         title: GestureDetector(
            //           onTap: () {
            //             print("Clicked on: ${program['name']}");
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => SubProgramScreen(
            //                   employeeId: program['id'],
            //                 ),
            //               ),
            //             );
            //           },
            //           child: Text(' ${program['name']}'),
            //         ),
            //         subtitle: program['alternative'] != null
            //             ? Text('Alternative: ${program['alternative']}')
            //             : null,
            //         trailing: IconButton(
            //           icon: Icon(Icons.delete, color: Colors.red),
            //           onPressed: () {
            //             print(program['name']);
            //             deleteApiProgram(context, program['name']);
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),

            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }



  void filterMemberList(String query) {
    setState(() {
      filteredMemberList = memberList
          .where((member) =>
      member['mobile'].toString().contains(query) ||
          (member['alternative'] != null &&
              member['alternative'].toString().contains(query)))
          .toList();
    });
  }

  void filterMemberListp(String query) {
    setState(() {
      filteredProgramList = programList
          .where((member) =>
      member['mobile'].toString().contains(query) ||
          (member['alternative'] != null &&
              member['alternative'].toString().contains(query)))
          .toList();
    });
  }

  Future<void> deleteApi(BuildContext context,String name) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "name": name,

    };
    print(data);
    try {
      final response = await _dio.post(Constant.BASE_URL + "api/cordinatorDeleteList", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        setState(() {
          fetchMemberList();
        });
        if (status == "true") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

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
  Future<void> deleteApiProgram(BuildContext context,String name) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "name": name,

    };
    print(data);
    try {
      final response = await _dio.post(Constant.BASE_URL + "api/programSubprogramDeleteList", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        setState(() {
          fetchProgramList();
        });
        if (status == "true") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

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

  Future<void> AddApi(BuildContext context,String name) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final data = {
      "name": name,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
    };
    print(data);
    try {
      final response = await _dio.post(Constant.BASE_URL + "api/cordinatorAddList", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        setState(() {
          fetchMemberList();
        });
        if (status == "true") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

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
  Future<void> AddApiProgram(BuildContext context,String name) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final data = {
      "name": name,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
    };
    print(data);
    try {
      final response = await _dio.post(Constant.BASE_URL + "api/programSubprogramAddList", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());
        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        setState(() {
          fetchProgramList();
        });
        if (status == "true") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey,
              textColor: Colors.white);

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
}

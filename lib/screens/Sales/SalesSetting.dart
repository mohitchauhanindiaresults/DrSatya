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
  TextEditingController addCenterController = TextEditingController();
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];
  List<Map<String, dynamic>> programList = [];
  List<Map<String, dynamic>> centerList = [];
  List<Map<String, dynamic>> filteredProgramList = [];
  List<Map<String, dynamic>> filteredCenterList = [];
  List<Map<String, dynamic>> filteredCenter = [];
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
    fetchCenters();
  }


  Future<void> fetchCenters() async {
    const url = 'https://clients.charumindworks.com/satya/api/get-all-centers';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['centers'] ?? [];
        setState(() {
          filteredCenterList = data.cast<Map<String, dynamic>>();
          isLoadingp = false;
          error = "";
        });
      } else {
        setState(() {
          error = "Failed to load centers";
          isLoadingp = false;
        });
      }
    } catch (e) {
      print("Error fetching centers: $e");
      setState(() {
        error = "Something went wrong";
        isLoadingp = false;
      });
    }
  }

  Future<void> addCenter(BuildContext context, String name) async {
    const url = 'https://clients.charumindworks.com/satya/api/add-centers';
    try {
      final response = await _dio.post(
        url,
        data: FormData.fromMap({'name': name}),
      );
      if (response.statusCode == 200 && response.data['status'] == "success") {
        Fluttertoast.showToast(msg: "Center added successfully");
        fetchCenters();
        addCenterController.text='';
      } else {
        Utils.showAlertDialog(context, response.data['message'] ?? "Failed to add center");
      }
    } catch (e) {
      print("Error adding center: $e");
      Utils.showAlertDialog(context, "An error occurred while adding the center");
    }
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
      print(response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        // print("bfggrfhgbf" + coordinatorList.toString());
        setState(() {
          // Filter and retrieve only yoga programs with a null parent ID
          programList = List<Map<String, dynamic>>.from(coordinatorList.where((element) => element['parent_id'] == null ));
          filteredProgramList = programList;
          isLoadingp = false;
          coordinatorControllerp.text='';
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

            SizedBox(width :1 ,height: 15.0),

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
                  'Note : To add Sub Programs, click on the Programs section and click to proceed.',
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
                        hintText: 'Add Program',
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
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            Center(
              child: Text(
                'Centers',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: addCenterController,
                      decoration: InputDecoration(
                        hintText: 'Add Center',
                      ),
                      onChanged: (query) {
                        filterCenterListp(query);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (addCenterController.text.isEmpty) {
                        Utils.showAlertDialog(context, "Text box cannot be empty");
                      } else {
                        addCenter(context, addCenterController.text);
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
              height: 200,
              child: ListView.builder(
                itemCount: filteredCenterList.length,
                itemBuilder: (context, index) {
                  final centers = filteredCenterList[index];
                  return ListTile(
                    title: GestureDetector(
                      onTap: () {
                        print("object Click");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SubProgramScreen(
                        //       employeeId: program['id'],
                        //     ),
                        //   ),
                        // );
                      },
                      child: Text(' ${centers['name']}'),
                    ),
                    subtitle: centers['alternative'] != null
                        ? Text('Alternative: ${centers['alternative']}')
                        : null,
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.red),
                      onPressed: () {
                        // deleteApiProgram(context, centers['name']);
                        print("object Click");
                        showUpdateCenterDialog(context,centers['id'].toString());
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


  Future<void> showUpdateCenterDialog(BuildContext context, String id) async {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> updateCenter() async {
              setState(() => isLoading = true);
              try {

                var response = await _dio.post(
                  'https://clients.charumindworks.com/satya/api/update-centers',
                  data: FormData.fromMap({
                    'id': id,
                    'name': nameController.text,
                  }),
                  options: Options(contentType: 'multipart/form-data'),
                );

                if (response.statusCode == 200) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Center updated successfully!')),
                  );
                  fetchCenters();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${response.statusMessage}')),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            }

            return AlertDialog(
              title: Text('Update Center'),
              content: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter new name'),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : updateCenter,
                  child: isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text('Update'),
                ),
              ],
            );
          },
        );
      },
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
  void filterCenterListp(String query) {
    setState(() {
      filteredCenterList = centerList
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

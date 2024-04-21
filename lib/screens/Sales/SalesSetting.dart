import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/Sales/AddSaleForm.dart';
import 'package:satya_new/screens/SubProgramScreen.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/Constant.dart';
import '../../utils/Utils.dart';
import '../AddEnquiryScreen.dart';
import '../UpdateEnquiryScreen.dart';

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

  @override
  void initState() {
    super.initState();
    fetchMemberList(); // Call the method to fetch the member list
    fetchProgramList();
  }

  // Method to fetch member list from API
  Future<void> fetchMemberList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await Dio().get('https://clients.charumindworks.com/satya/api/cordinatorAddList');
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

  Future<void> fetchProgramList() async {
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint
      Response response = await Dio().get('https://clients.charumindworks.com/satya/api/programSubprogramAddList');
      Map<String, dynamic> responseData = response.data;
      print(response.data);

      if (responseData['status'] == 'false') {
        List<dynamic> coordinatorList = responseData['programList'];
        print("bfggrfhgbf" + coordinatorList.toString());
        setState(() {
          // Filter and retrieve only yoga programs with a null parent ID
          programList = List<Map<String, dynamic>>.from(coordinatorList.where((element) => element['parent_id'] == null ));
          filteredProgramList = programList;
          isLoadingp = false;

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Setting Configuration',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.0),

          Center(
            child: Text(
              'Coordinator names',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.black,
              ),
            ),
          ),

          // Add a search bar
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: coordinatorController,
                    decoration: InputDecoration(
                      hintText: 'Fill Coordinator',
                    ),
                    onChanged: (query) {
                      filterMemberList(query);
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add your API call logic here
                    // For example, you can call a method like hitApi();
                    if(coordinatorController.text.isEmpty){
                      Utils.showAlertDialog(context, "Text box cannot be empty");
                    }else{
                      AddApi(context,coordinatorController.text);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),

          // Display the member list
          isLoadingp
              ? CircularProgressIndicator()
              : error.isNotEmpty
              ? Text(error)
              : Expanded(
            child: ListView.builder(
              itemCount: filteredMemberList.length,
              itemBuilder: (context, index) {
                final member = filteredMemberList[index];
                return ListTile(
                  title: Text(
                    ' ${member['name']}',
                  ),
                  subtitle: member['alternative'] != null
                      ? Text(
                      'Alternative: ${member['alternative']}')
                      : null,
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      print(member['name']);
                      deleteApi(context, member['name']);
                    },
                  ),
                );
              },
            ),
          ),


          SizedBox(height: 15.0),

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

          // Add a search bar
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
                    // Add your API call logic here
                    // For example, you can call a method like hitApi();
                    if(coordinatorControllerp.text.isEmpty){
                      Utils.showAlertDialog(context, "Text box cannot be empty");
                    }else{
                      AddApiProgram(context,coordinatorControllerp.text);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),

          // Display the member list
          // Display the program list
          isLoadingp
              ? CircularProgressIndicator()
              : error.isNotEmpty
              ? Text(error)
              : Expanded(
            child: ListView.builder(
              itemCount: filteredProgramList.length,
              itemBuilder: (context, index) {
                final program = filteredProgramList[index];
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      // Perform action when name is clicked
                      print("Clicked on: ${program['name']}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SubProgramScreen(
                                employeeId: program['id'],
                              ),
                        ),
                      );

                      // You can perform any action here
                    },
                    child: Text(
                      ' ${program['name']}',
                    ),
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

        ],
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
      final response =
      await dio.post(Constant.BASE_URL + "api/cordinatorDeleteList", data: data);

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
      final response =
      await dio.post(Constant.BASE_URL + "api/programSubprogramDeleteList", data: data);

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
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "name": name,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
    };
    print(data);
    try {
      final response =
      await dio.post(Constant.BASE_URL + "api/cordinatorAddList", data: data);

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
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "name": name,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
    };
    print(data);
    try {
      final response =
      await dio.post(Constant.BASE_URL + "api/programSubprogramAddList", data: data);

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
}

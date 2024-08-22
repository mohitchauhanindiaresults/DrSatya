import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:satya_new/screens/DashboardScreen.dart';
import 'package:satya_new/screens/Yoga/AttendanceListing.dart';
import '../../model/Member.dart';
import '../../utils/Utils.dart';

class AddAttendanceScreen extends StatefulWidget {
  @override
  _AddAttendanceScreenState createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  List<Member> members = [];
  Member? selectedMember;
  String selectedMode = 'online';
  String selectedCentre = 'shalimar';
  String selectedType = 'Current Member';
  TextEditingController teacherController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMembers();
  }

  void fetchMembers() async {
    try {
      var response = await Dio().get('https://clients.charumindworks.com/satya/api/memberlist');
      if (response.data['status'] == 'success') {
        setState(() {
          members = (response.data['members'] as List).map((memberData) => Member.fromJson(memberData)).toList();
        });
      }
    } catch (e) {
      print('Error fetching members: $e');
    }
  }
  void addAttendance() async {
    if (selectedMember == null) return;

    var data = {
      'member_id': selectedMember!.id.toString(),
      'type': selectedType,
      'mode': selectedMode,
      'centre': selectedCentre,
      'teacher': teacherController.text,
      'remark': remarkController.text,
    };
    print(data.toString());

    try {
      var response = await Dio().post(
        'https://clients.charumindworks.com/satya/api/addattendance',
        data: data,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        Fluttertoast.showToast(msg: "Attendance added successfully");
        Utils.navigateToPage(context, DashboardScreen());
      } else if (response.statusCode == 409) {
        print('Attendance already exists');
        Fluttertoast.showToast(msg: "Attendance already exists");
      } else {
        print('Failed to add attendance: ${response.data}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Attendance already exists");
      print('Error adding attendance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Attendance',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list), // Use an appropriate icon for your use case
            onPressed: () {
              // Define your action here
              // For example, navigate to the member list screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AttendanceListing()), // Replace with your actual member list screen
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
              children: [
                buildDropdownButtonFormField<Member>(
                  'Select Member',
                  selectedMember,
                  members.map((member) => DropdownMenuItem(
                    value: member,
                    child: Text('${member.firstName} ${member.lastName}'),
                  )).toList(),
                      (value) => setState(() => selectedMember = value),
                ),
                buildDropdownButtonFormField<String>(
                  'Mode',
                  selectedMode,
                  ['online', 'home', 'center'].map((mode) => DropdownMenuItem(
                    value: mode,
                    child: Text(mode),
                  )).toList(),
                      (value) => setState(() => selectedMode = value!),
                ),
                buildDropdownButtonFormField<String>(
                  'Centre',
                  selectedCentre,
                  ['shalimar', 'ashok vihar'].map((centre) => DropdownMenuItem(
                    value: centre,
                    child: Text(centre),
                  )).toList(),
                      (value) => setState(() => selectedCentre = value!),
                ),
                buildDropdownButtonFormField<String>(
                  'Status',
                  selectedType,
                  ['Current Member', 'Old Member', 'Defaulter'].map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  )).toList(),
                      (value) => setState(() => selectedType = value!),
                ),
                buildTextFormField(teacherController, 'Teacher'),
                buildTextFormField(remarkController, 'Remark'),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: addAttendance,
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
                    'Submit Attendance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Gilroy',
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

  Widget buildDropdownButtonFormField<T>(
      String labelText,
      T? selectedValue,
      List<DropdownMenuItem<T>> items,
      void Function(T?) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        value: selectedValue,
        onChanged: onChanged,
        items: items,
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
}

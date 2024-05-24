import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satya_new/screens/Billing/BillingSelection.dart';
import 'package:satya_new/screens/Holistic%20history/HolisticSelection.dart';
import 'package:satya_new/screens/Sales/SalesSelection.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';
import 'AddMemberScreen.dart';
import 'LoginScreen.dart';
import 'MemberListScreen.dart';
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name = "";
  String role = "";
  List<String> buttonLabels = [];
  List<IconData> iconList = [
    Icons.add_box_rounded,
    Icons.list,
    Icons.point_of_sale_sharp,
    Icons.format_align_center_sharp,
    Icons.app_registration,
    Icons.speaker_phone_sharp,
    Icons.directions_walk,
    Icons.thermostat,
    Icons.code,
    Icons.event,
    Icons.golf_course,
    Icons.production_quantity_limits,
    Icons.difference,
    Icons.history,
    Icons.account_balance_rounded,
    Icons.girl,
    Icons.call,
    Icons.model_training_sharp,
    Icons.call,
    Icons.report_sharp,
    Icons.follow_the_signs,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the profile name when the screen appears
    initate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF14B3B4),
          title: Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 20, // Adjust the font size
              fontWeight: FontWeight.bold, // Add boldness
              letterSpacing: 1, // Adjust letter spacing
              color: Colors.white, // Text color
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF14B3B4), // Adjust as needed
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF14B3B4),
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        role,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Handle logout logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
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
          child: RefreshIndicator(
            onRefresh: () async {
              // Implement your refresh logic here
              // await fetchWorks(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: buttonLabels.length,
                itemBuilder: (context, index) {
                  return _buildDashboardButton(
                    buttonLabels[index],
                    iconList[index],
                    _getRandomColor(),
                    context,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  Widget _buildDashboardButton(
      String label, IconData icon, Color color, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if ("Add Users" == label) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddMemberScreen(), // Replace AddMemberScreen with your actual screen class
            ),
          );
        }
        if ("Master Data" == label) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MemberListScreen(), // Replace AddMemberScreen with your actual screen class
            ),
          );
        }  if ("Sales" == label) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SalesSelection(), // Replace AddMemberScreen with your actual screen class
            ),
          );
        } if ("Billing & Registration" == label) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BilllingSelection(), // Replace AddMemberScreen with your actual screen class
            ),
          );
        }if ("Holistic History" == label) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HolisticSelection(), // Replace AddMemberScreen with your actual screen class
            ),
          );

        }if ("Consultations" == label) {


        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         RulesAssign(), // Replace AddMemberScreen with your actual screen class
        //   ),
        // );
        // Handle button tap
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        padding: EdgeInsets.all(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

    void initate() async {
      name = (await Utils.getStringFromPrefs(Constant.EMAIL))!;
      role = (await Utils.getStringFromPrefs(Constant.NAME))!;
      setState(() {});

      Timer(Duration(milliseconds: 50), () async {
        // fetchWorks(context);

        String? roll = await Utils.getStringFromPrefs(Constant.DESIGNATION);

        buttonLabels = [];
        List<String> validIds = roll!
            .replaceAll("[", "")
            .replaceAll("]", "")
            .replaceAll("\"", "")
            .split(",");
        print(validIds);

        addIfValid(String id, String label) {
          if (validIds.contains(id)) {
            buttonLabels.add(label);
          }
        }

        addIfValid("1", "Add Users");
        addIfValid("2", "Master Data");
        addIfValid("3", "Sales");
        addIfValid("4", "Billing & Registration");
       // addIfValid("5", "Registration");
        addIfValid("6", "Consultations");
        addIfValid("7", "Yoga");
        addIfValid("8", "Therapy");
        addIfValid("9", "Programs");
        addIfValid("10", "Events");
        addIfValid("11", "Courses");
        addIfValid("12", "Products");
        addIfValid("13", "Uniqueness");
        addIfValid("14", "Holistic History");
        addIfValid("15", "Office Administration");
        addIfValid("16", "Accounts");
        addIfValid("17", "HR");
        addIfValid("18", "Customer Care");
        addIfValid("19", "Trainings");
        addIfValid("20", "Reports");
        addIfValid("21", "Follow-up");

        setState(() {});
        print(buttonLabels);
      });
    }
}

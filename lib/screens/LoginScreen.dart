
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import '../model/LoginApiModel.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';
import 'DashboardScreen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
String jsonResponseeee='';

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14B3B4), Colors.white],
            // Adjust gradient colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                "Dr.Satya",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust text color as needed
                ),
              ),
              SizedBox(height: 20.0),

              // Logo
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        'assets/images/logo.png'), // Add your logo image path
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Email field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 30.0),

              // Password field
              TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 50.0),

              // Login button
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DashboardScreen(),
                  //   ),
                  // );
                //  Fluttertoast.showToast(msg: "Login sucessfully");
                  loginApi(context);
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF14B3B4),
                  // Use the same color as the gradient
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                  elevation: 5,
                  // Add a subtle shadow
                  shadowColor: Colors.grey,
                  // Shadow color
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0), // Adjust padding
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adjust text color as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initate() async {
    bool isNetworkAvailable = await Utils.checkNetworkStatus();

    emailController.text = (await Utils.getStringFromPrefs(Constant.EMAIL)) ?? '';
    passwordcontroller.text = (await Utils.getStringFromPrefs(Constant.PASSWORD)) ?? '';

    if (isNetworkAvailable) {

    } else {

      // Show an error message or perform an action if there is no network
      Utils.showAlertDialog(
          context, "No internet connection. Please check your connection.");
    }
  }

  Future<void> loginApi(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    LoginApiModel? profileDetails;

    String message = "";
    final data = {
      "mobile": emailController.text,
      "password": passwordcontroller.text,
    };
    print("Login data: $data");

    try {
      final response = await http.post(
        Uri.parse(Constant.BASE_URL + "api/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = json.decode(response.body);
        print("Response JSON: $jsonResponse");

        profileDetails = LoginApiModel.fromJson(jsonResponse);
        message = profileDetails.message.toString();
        String? status = profileDetails.status;

        print("Message: $message");

        if (status == "success") {
          print("track1");

          // Save user details in shared preferences
          String roll = profileDetails.user!.id.toString();
          Utils.saveStringToPrefs(Constant.USER_ID, profileDetails.user!.id.toString());
          Utils.saveStringToPrefs(Constant.ROLL_ID, roll);
          Utils.saveStringToPrefs(Constant.NAME, profileDetails.user!.name.toString());
          Utils.saveStringToPrefs(Constant.TOKEN, profileDetails.user!.accessToken.toString());
          Utils.saveStringToPrefs(Constant.DESIGNATION, profileDetails.user!.designation.toString());
          Utils.saveStringToPrefs(Constant.PASSWORD, passwordcontroller.text);
          Utils.saveStringToPrefs(Constant.EMAIL, emailController.text);

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
          // Handle non-successful status
          print("track2");
          pd.close(delay: 0);
          Utils.showAlertDialog(context, message);

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
          );
        }
      } else {
        print("track3");
        pd.close(delay: 0);
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");

        Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
        throw Exception('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("track4");
      print('Error: $e');
      pd.close(delay: 0);

      // More specific error handling
      if (e is SocketException) {
        Utils.showAlertDialog(context, "Network Error: ${e.message}");
      } else if (e is FormatException) {
        Utils.showAlertDialog(context, "Response Parsing Error: ${e.message}");
      } else {
        Utils.showAlertDialog(context, "An unexpected error occurred: ${e.toString()}");
      }

      throw Exception('An error occurred during login');
    }
  }
}

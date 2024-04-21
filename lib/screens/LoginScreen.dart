import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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
                  loginApi(context);


                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF14B3B4),
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

    emailController.text = (await Utils.getStringFromPrefs(Constant.EMAIL))!;
    passwordcontroller.text = (await Utils.getStringFromPrefs(Constant.PASSWORD))!;
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
    String message = "";
    final Dio dio = Dio();
    LoginApiModel? profileDetails;
    final data = {
      "mobile": emailController.text,
      "password": passwordcontroller.text,
    };
    print(data);
    String error = "";
    try {
      final response =
          await dio.post(Constant.BASE_URL + "api/login", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        Utils.printLongString(response.toString());
        jsonResponseeee = response.toString();

        Map<String, dynamic> responseMap = json.decode(response.toString());
        profileDetails = LoginApiModel.fromJson(responseMap);

        message = profileDetails.message.toString();
        String? status = profileDetails.status;

        print(message);

        if (status == "success") {


          String roll=profileDetails.user!.id.toString();
          Utils.saveStringToPrefs(Constant.USER_ID,profileDetails.user!.id.toString());
          Utils.saveStringToPrefs(Constant.ROLL_ID,roll);
          Utils.saveStringToPrefs(Constant.NAME,profileDetails.user!.name.toString());
          Utils.saveStringToPrefs(Constant.TOKEN,profileDetails.user!.accessToken.toString());
          Utils.saveStringToPrefs(Constant.DESIGNATION,profileDetails.user!.designation.toString());
          Utils.saveStringToPrefs(Constant.PASSWORD,passwordcontroller.text);
          Utils.saveStringToPrefs(Constant.EMAIL,emailController.text);
    //      Utils.saveStringToPrefs(Constant.ROLES,profileDetails.user!.roles!.name.toString());

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
          Utils.showAlertDialog(
              context, message);

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
        throw Exception('Login failed');
      }
    } catch (e) {
      print('Error: $e');
      pd.close(delay: 0);
      Map<String, dynamic> response = json.decode(jsonResponseeee);

      // Retrieve the value of the "message" key
      String message = response['message'];

      // Print the result
      print('Message: $message');
      Utils.showAlertDialog(context, message);
      throw Exception('An error occurred during login');
    }
  }
}

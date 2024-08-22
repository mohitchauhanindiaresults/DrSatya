import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<void> saveStringToPrefs(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getStringFromPrefs(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }


  static void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please check your internet connection.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  static String formDataToString(FormData formData) {
    StringBuffer buffer = StringBuffer();

    for (var entry in formData.fields) {
      buffer.write('${entry.key}: ${entry.value}\n');
    }

    return buffer.toString();
  }
  static int getIdBySubName(String jsonResponse, String subName) {
    final decodedResponse = json.decode(jsonResponse);

    if (decodedResponse['data'] != null &&
        decodedResponse['data']['data'] != null &&
        decodedResponse['data']['data']['PacketInBankClasswise'] != null) {
      final packetInBankClasswise = decodedResponse['data']['data']['PacketInBankClasswise'];

      for (var packet in packetInBankClasswise) {
        if (packet['subName'] == subName) {
          return packet['id'];
        }
      }
    }

    // If the subName is not found, you can return a default value or handle it as needed.
    return -1; // Return -1 as an example for not found.
  }

  static void PermisionAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Alert'),
              content: Text(
                  "To enhance the security and authenticity of student examinations, the app requires access to your location and camera. These permissions are necessary for verifying teacher presence and identity during exams. Please enable both location and camera access to ensure a smooth and secure examination process. You can update these settings in your device's Settings app."),
              actions: [
                TextButton(
                  child:
                  Text('Close', style: TextStyle(color: Color(0xFF01579B))),
                  // Negative button
                  onPressed: () {
                    // Close the dialog without performing any action
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static void showAlertDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'ok', style: TextStyle(color: Color(0xFF14B3B4)),),

            ),
          ],
        );
      },
    );
  }

  static bool isStrongPassword(String password) {
    // Define a regular expression pattern to match the password criteria
    RegExp regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).{8,}$',
    );

    // Use the RegExp's hasMatch method to check if the password matches the pattern
    return regex.hasMatch(password);
  }
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
 static Future<bool> checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
  static String generateTimestampInMilliseconds() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Get the timestamp in milliseconds
    int timestampInMilliseconds = now.millisecondsSinceEpoch;

    // Convert the timestamp to a string
    String timestamp = timestampInMilliseconds.toString();

    // Remove the last 5 characters
    String truncatedTimestamp = timestamp.substring(0, timestamp.length - 5);

    return truncatedTimestamp;
  }  static String generateTimestampInMillisecondsLong() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Get the timestamp in milliseconds
    int timestampInMilliseconds = now.millisecondsSinceEpoch;

    // Convert the timestamp to a string
    String timestamp = timestampInMilliseconds.toString();

    // Remove the last 5 characters
    String truncatedTimestamp = timestamp.substring(0, timestamp.length - 2);

    return truncatedTimestamp;
  }
 static  bool isEmailValid(String email) {
    // Define a regular expression pattern for a valid email address
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );

    // Check if the email matches the pattern
    return emailRegex.hasMatch(email);
  }

 static String generateTimestamp() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Format the date and time as a string
    String timestamp = "${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)} "
        "${_formatNumber(now.hour)}:${_formatNumber(now.minute)}:${_formatNumber(now.second)}";

    return timestamp;
  }

  static String _formatNumber(int number) {
    // Helper function to format numbers with leading zeros
    return number.toString().padLeft(2, '0');
  }


  static String getCurrentFormattedDate() {
    DateTime currentDate = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(currentDate);
  }
  static String getCurrentFormattedTime() {
    DateTime currentTime = DateTime.now();
    return DateFormat('HH:mm:ss').format(currentTime);
  }

  static void addAllUniqueClasses(String jsonResponse, List<String> dropdownItemList) {
    final decodedResponse = json.decode(jsonResponse);

    if (decodedResponse['data'] != null &&
        decodedResponse['data']['data'] != null &&
        decodedResponse['data']['data']['PacketInBank'] != null) {
      final packetInBank = decodedResponse['data']['data']['PacketInBank'];

      for (var packet in packetInBank) {
        String currentClass = packet['class'];
        if (!dropdownItemList.contains(currentClass)) {
          dropdownItemList.add(currentClass);
        }
      }
    }
  }
  static String replaceSchoolCodeInJson(String originalJson, String newSchoolCode) {
    try {
      // Parse the original JSON string
      Map<String, dynamic> jsonData = json.decode(originalJson);

      // Replace the "SchoolCode" value with the newSchoolCode
      jsonData['SchoolCode'] = newSchoolCode;

      // Convert the modified data back to a JSON string
      String modifiedJson = json.encode(jsonData);

      return modifiedJson;
    } catch (e) {
      // Handle JSON parsing errors
      print("Error parsing or modifying JSON: $e");
      return originalJson; // Return the original JSON on error
    }
  }
  static void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
  }
  static int getNoOfBlankSheetFromJsonString(String jsonString, String desiredClass) {
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    final List<dynamic> table = jsonResponse['data']['data']['Table'];

    for (var entry in table) {
      if (entry['class'] == desiredClass) {
        return entry['NoOfBlankSheet'];
      }
    }

    return 0; // Return a default value if the class is not found
  }


  static String formDataToStringg(FormData formData) {
    StringBuffer buffer = StringBuffer();

    for (var entry in formData.fields) {
      buffer.write('${entry.key}: ${entry.value}\n');
    }

    return buffer.toString();
  }

// ... Add more methods for different data types as needed
}
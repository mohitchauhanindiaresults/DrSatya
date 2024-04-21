import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/Utils.dart';

class AddHealthScore extends StatefulWidget {

  final int employeeId;

  AddHealthScore({required this.employeeId});
  @override
  _AddHealthScoreState createState() => _AddHealthScoreState();
}

class _AddHealthScoreState extends State<AddHealthScore> {
  late List<String?> selectedValues;
  List<bool> validationErrors = List.filled(50, false);

  // Custom list of questions
  List<String> questions = [
    "Whole day full of energy?",
    "5-7 hours sound sleep?",
    "When wake-up in the morning the body is energetic?",
    "Stool is solid, clean & regular?",
    "Work actively the whole day without tiredness?",
    "The belly is not protruding out as compared to the chest?",
    "No desire of intoxicating products?",
    "Every moment feel happy and peaceful?",
    "Always smile on the face?",
    "Always talk politely and sweetly?",
    "Eyes are bright and fearless?",
    "Always positive thinking?",
    "Sweat & gas are odourless?",
    "Spine is always straight?",
    "No pain in the body?",
    "No medicines on regular basis?",
    "Ideal weight?",
    "Skin is soft and smooth?",
    "Capacity to bear heat and cold?",
    "Free from anger, ego, sadness, fear, tension, irritation, and frustration?",
    "Body is fully flexible?",
    "Daily intake of important herbs like aloe vera and amla?",
    "Daily intake of herbal tea?",
    "Daily intake of fruits?",
    "Daily intake of salads?",
    "Daily intake of nuts and dry foods?",
    "Daily intake of milk and milk products?",
    "Going through regular annual health checkup?",
    "Regular practice of yoga or exercise (30-60 minutes)?",
    "Regular practice of pranayama (20-30 minutes)?",
    "Regular practice of meditation?",
    "Regular 3-5 Km brisk walk?",
    "At least 5-6 days a week hundred percent healthy diet intake?",
    "Drink solids to chewing food properly?",
    "Daily intake of 10-12 glasses of water?",
    "Dinner is lightest?",
    "Wake up and sleep time is fix?",
    "Daily morning and evening toothbrush?",
    "Daily use of oil in nose,hairs & body?",
    "Once a week body massage?",
    "Practice of facial yoga daily?",
    "Foot wash before sleep?",
    "Diet intake according to body type?",
    "Once a week fasting?",
    "Daily 20 to 30 minutes sun bath?",
    "Once a week mud therapy?",
    "Rice and wheat intake maximum once or twice a day?",
    "Once a week full rest from the work?",
    "Surrounded by positive and healthy people?",
    "100% diseases free life? & 100% stress free life?"
    // Add your questions here...
  ];

  @override
  void initState() {
    super.initState();
    selectedValues = List<String?>.filled(50, null); // Change the size to 50
  }

  Future<void> submitData() async {
    // Check if selectedValues is null or empty
    if (selectedValues == null || selectedValues.isEmpty) {
      // Handle the case where selectedValues is null or empty
      print('Error: selectedValues is null or empty.');
      return;
    }

    // Check if any question is unanswered
    bool hasUnansweredQuestions = false;
    for (int i = 0; i < selectedValues.length; i++) {
      if (selectedValues[i] == null) {
        setState(() {
          validationErrors[i] = true;
        });
        hasUnansweredQuestions = true;
      }
    }

    if (hasUnansweredQuestions) {
      // Show dialog if there are unanswered questions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Validation Error"),
            content: Text("Please answer all questions."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");

    // Construct request payload
    Map<String, String> requestData = {'login_id': widget.employeeId.toString()};
    for (int i = 0; i < selectedValues.length; i++) {
      // Check if selectedValues[i] is null
      if (selectedValues[i] != null) {
        requestData['q${i + 1}'] = selectedValues[i]!;
      } else {
        // Handle the case where selectedValues[i] is null
        print('Error: selectedValues[$i] is null.');
      }
    }
    print("1234567890"+requestData.toString());

    // Submit data to API
    try {
      final response = await http.post(
        Uri.parse('https://clients.charumindworks.com/satya/api/addHealthScore'),
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      // Handle response here
      print(response.statusCode);
        if(response.statusCode==200 ){
          pd.close();
          Fluttertoast.showToast(msg: "Health Score Saved");
          Navigator.of(context).pop();

        }
      else{
        pd.close();
        Utils.showAlertDialog(context, "SOMETHING WENT WRONG!!");
      }
      print(response.body);
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add Health Score',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(questions.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}: ${questions[index]}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Radio(
                        value: 'yes',
                        groupValue: selectedValues[index],
                        onChanged: (value) {
                          setState(() {
                            selectedValues[index] = value as String?;
                            validationErrors[index] = false;
                          });
                        },
                      ),
                      Text('Yes'),
                      SizedBox(width: 10),
                      Radio(
                        value: 'no',
                        groupValue: selectedValues[index],
                        onChanged: (value) {
                          setState(() {
                            selectedValues[index] = value as String?;
                            validationErrors[index] = false;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                  if (validationErrors[index])
                    Text(
                      "Please select an option.",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitData,
        child: Icon(Icons.save),
      ),
    );
  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../utils/Constant.dart';
import '../utils/Utils.dart';
import 'DashboardScreen.dart';

class UpdateEnquiryScreen extends StatefulWidget {
  final int employeeId;

  UpdateEnquiryScreen({required this.employeeId});

  @override
  _UpdateEnquiryScreenState createState() => _UpdateEnquiryScreenState();
}

class _UpdateEnquiryScreenState extends State<UpdateEnquiryScreen> {
  late Future<Map<String, dynamic>> employeeDetails;

  TextEditingController centerController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController coordinatorController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController loginIdController = TextEditingController();
  String jsonResponseeee = "";

  List<String> ageGroups = [];
  List<String> genders = [];
  List<String> sources = [];
  List<String> countries = [];
  List<String> states = [];
  List<String> cities = [];

  String selectedCountry = '';
  String selectedState = '';
  String selectedCity = '';
  String apiToken = ""; // Variable to store the obtained API token

  Future<void> getAccessToken() async {
    final response = await http.get(
      Uri.parse("https://www.universal-tutorial.com/api/getaccesstoken"),
      headers: {
        "Accept": "application/json",
        "api-token":
        "wvjt4YD27Xb6yudVaAP1pkoL1iTXDO8ekg3NaJN9aw3tRk41udDhWndnEyhqd0Ewzf0",
        "user-email": "mohit.chauhan@indiaresults.com",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      apiToken = data['auth_token'].toString();
    } else {
      throw Exception('Failed to get access token');
    }
  }

  // Function to fetch countries from API using the obtained token
  Future<void> fetchCountries() async {
    await getAccessToken();

    final response = await http.get(
      Uri.parse("https://www.universal-tutorial.com/api/countries/"),
      headers: {
        "Authorization": "Bearer $apiToken",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Convert the list to a set to remove duplicates and then back to a list
      final uniqueCountriesSet =
      data.map((item) => item['country_name'].toString()).toSet();
      setState(() {
        countries = uniqueCountriesSet.toList();
      });
      print(countries);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  // Function to fetch states from API based on the selected country
  Future<void> fetchStates(String country) async {
    final response = await http.get(
      Uri.parse("https://www.universal-tutorial.com/api/states/$country"),
      headers: {
        "Authorization": "Bearer $apiToken",
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        states = data.map((item) => item['state_name'].toString()).toList();
      });
      print(states);
    } else {
      throw Exception('Failed to load states');
    }
  }

  // Function to fetch cities from API based on the selected state
  Future<void> fetchCities(String state) async {

    final response = await http.get(
      Uri.parse("https://www.universal-tutorial.com/api/cities/$state"),
      headers: {
        "Authorization": "Bearer $apiToken",
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        cities = data.map((item) => item['city_name'].toString()).toList();
      });
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  void initState() {
    super.initState();
    centerController.text = Utils.generateTimestampInMilliseconds();
    fetchCountries();

    // Set initial values for dropdowns
    if (countries.isNotEmpty) {
      selectedCountry = countries.first;
    }

    if (states.isNotEmpty) {
      selectedState = states.first;
    }

    if (cities.isNotEmpty) {
      selectedCity = cities.first;
    }
    initaite();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Update Enquiry',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
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
                        controller: centerController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Center',
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
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile',
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
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Alternative Mobile',
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
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
                        controller: professionController,
                        decoration: InputDecoration(
                          labelText: 'Profession',
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
                        controller: qualificationController,
                        decoration: InputDecoration(
                          labelText: 'Qualification',
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
                        value: selectedCountry.isNotEmpty &&
                            countries.contains(selectedCountry)
                            ? selectedCountry
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCountry = value ?? '';
                            selectedState = '';
                            selectedCity = '';
                            states.clear();
                            cities.clear();
                            print("gbghbihfjvuhhuhgvbduhsi");
                            fetchStates(selectedCountry);
                          });
                        },
                        items: countries
                            .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Country',
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
                      // Add the state dropdown
                      DropdownButtonFormField<String>(
                        value: selectedState.isNotEmpty &&
                            states.contains(selectedState)
                            ? selectedState
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedState = value!;
                            selectedCity = '';
                            cities.clear();
                            fetchCities(selectedState);
                          });
                        },
                        items: states
                            .map((state) => DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select State',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      // Add the city dropdown
                      DropdownButtonFormField<String>(
                        value: selectedCity.isNotEmpty &&
                            cities.contains(selectedCity)
                            ? selectedCity
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCity = value!;
                          });
                        },
                        items: cities
                            .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select City',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 10.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),


                      SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: ageGroupController.text.isNotEmpty
                            ? ageGroupController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            ageGroupController.text = value!;
                          });
                        },
                        items: [
                          '1-5',
                          '6-10',
                          '11-15',
                          '16-20',
                          '21-25',
                          '26-30',
                          '31-35',
                          '36-40',
                          '41-45',
                          '46-50',
                          '51-55',
                          '56-60+'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Age Group',
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
                        value: genderController.text.isNotEmpty
                            ? genderController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            genderController.text = value!;
                          });
                        },
                        items: ['Male', 'Female', 'Others'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Gender',
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
                        controller: coordinatorController,
                        decoration: InputDecoration(
                          labelText: 'Coordinator',
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
                        value: sourceController.text.isNotEmpty
                            ? sourceController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            sourceController.text = value!;
                          });
                        },
                        items: [
                          'Google',
                          'Instagram',
                          'Facebook',
                          'Linkedin',
                          'NewsPaper',
                          'By a friend',
                          'Others'
                        ].map((String value) {
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
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    if (centerController.text.isEmpty ||
                        firstNameController.text.isEmpty ||
                        lastNameController.text.isEmpty ||
                        mobileController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        professionController.text.isEmpty ||
                        qualificationController.text.isEmpty ||
                        ageGroupController.text.isEmpty ||
                        genderController.text.isEmpty ||
                        coordinatorController.text.isEmpty ||
                        sourceController.text.isEmpty) {
                      // Show an error message or handle the validation failure as needed.
                      Utils.showAlertDialog(context, "Please fill in all fields");
                    } else if (!Utils.isEmailValid(emailController.text)) {
                      Utils.showAlertDialog(
                          context, "Please enter correct email !!");
                    } else if (mobileController.text.length != 10) {
                      Utils.showAlertDialog(context, "Enter correct mobile !!");
                    } else if (alternativeMobileController.text.length != 10) {
                      Utils.showAlertDialog(context, "Enter correct mobile !!");
                    } else if (mobileController.text ==
                        alternativeMobileController.text) {
                      Utils.showAlertDialog(
                          context, "Numbers cannot be same !!");
                    } else {
                      // All controllers have non-empty text, proceed with addEnquiry.

                      addEnquiry(context);
                    }
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
                    'Update Enquiry',
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

  Future<void> addEnquiry(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "center": centerController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "mobile": mobileController.text,
      "alternative": alternativeMobileController.text,
      "email": emailController.text,
      "country": selectedCountry,
      "state":selectedState,
      "city": selectedCity,
      "address": addressController.text,
      "profession": professionController.text,
      "qualification": qualificationController.text,
      "age_group": ageGroupController.text,
      "gender": genderController.text,
      "cordinator": coordinatorController.text,
      "source": sourceController.text,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
      "id": widget.employeeId.toString()
    };
    print(data);
    try {
      final response =
          await dio.post(Constant.BASE_URL + "api/updateEnquiry", data: data);

      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());

        Map<String, dynamic> responseMap = json.decode(response.toString());

        // You may need to create a model class for the API response
        // For example, if it's similar to the AddMember class, you can use it here

        message = responseMap['message'].toString();
        String status = responseMap['status'].toString();

        if (status == "success") {
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
    alternativeMobileController.text = details['alternative'].toString();
    emailController.text = details['email'].toString();
    addressController.text = details['address'].toString();
    professionController.text = details['profession'].toString();
    qualificationController.text = details['qualification'].toString();
    ageGroupController.text = details['age_group'].toString();
    ageGroups = [
      '1-5',
      '6-10',
      '11-15',
      '16-20',
      '21-25',
      '26-30',
      '31-35',
      '36-40',
      '41-45',
      '46-50',
      '51-55',
      '56-60+'
    ];
    genderController.text = details['gender'].toString();
    genders = ['Male', 'Female', 'Others'];
    coordinatorController.text = details['cordinator'].toString();
    sourceController.text = details['source'].toString();
   // selectedCountry =  details['country'].toString();
 //   selectedState =  details['state'].toString();
 //   selectedCity =  details['city'].toString();


    sources = [
      'Google',
      'Instagram',
      'Facebook',
      'Linkedin',
      'NewsPaper',
      'By a friend',
      'Others'
    ];

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
}

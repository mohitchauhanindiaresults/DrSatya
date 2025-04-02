import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../utils/ApiInterceptor.dart';
import '../utils/Constant.dart';
import '../utils/Utils.dart';
import 'DashboardScreen.dart';

class AddEnquiryScreen extends StatefulWidget {
  @override
  _AddEnquiryScreenState createState() => _AddEnquiryScreenState();
}

class _AddEnquiryScreenState extends State<AddEnquiryScreen> {
  TextEditingController centerController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternativeMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController selectCenterController = TextEditingController();
  TextEditingController callingStatusController = TextEditingController();
  TextEditingController coordinatorController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController loginIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String jsonResponseeee = "";
  List<String> countries = [];
  List<String> states = [];
  List<String> cities = [];
  List<String> coordinators = [];
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];

  String selectedCountry = '';
  String countryJson = '';
  String statesJson = '';
  String cityJson = '';
  String selectedCoordinator = '';
  String selectedState = '';
  String selectedCity = '';
  String apiToken = ""; // Variable to store the obtained API token
  String email = "";
  bool isLoading = true;
  String error = '';
  String acessToken = ""; // Variable to store the obtained API token
  final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance

  Future<void> fetchCountries() async {
    try {
      var response = await _dio.get(
        "${Constant.BASE_URL_2}${Constant.FETCH_COUNTRY}",
      );
      if (response.statusCode == 200) {
        countryJson = response.toString();
        final List<dynamic> data = response.data['country'];
        Set<String> uniqueCountries = data.map((e) => e['name'].toString()).toSet();

        setState(() {
          countries = uniqueCountries.toList();
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      print('Error fetching countries: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching countries: $e')),
      );
    }
  }
  // Function to fetch states from API based on the selected country
  Future<void> fetchStates(String country) async {
    print(Utils.getIdBySubName(countryJson, country));

    var response = await _dio.get(
      "${Constant.BASE_URL_2}${Constant.FETCH_STATES}/${Utils.getIdBySubName(countryJson, country)}",
    );

    if (response.statusCode == 200) {
      statesJson = response.toString();
      final List<dynamic> data = response.data['state'];
      Set<String> uniqueStates = data.map((e) => e['name'].toString()).toSet();
      setState(() {
        states = uniqueStates.toList();
      });
    } else {
      throw Exception('Failed to load states');
    }
  }

  Future<void> fetchCities(String state) async {

    print(statesJson);
    print(state);

    print(Utils.getIdBySubNameState(statesJson, state));
    try {
      var response = await _dio.get(
        "${Constant.BASE_URL_2}${Constant.FETCH_CITY}/${Utils.getIdBySubNameState(statesJson, state)}",
      );

      if (response.statusCode == 200) {
        cityJson = response.toString();
        final List<dynamic> data = response.data['city'];
        Set<String> uniqueCities = data.map((e) => e['name'].toString()).toSet();

        setState(() {
          cities = uniqueCities.toList();
        });
      } else {
        throw Exception('Failed to load city');
      }
    } catch (e) {
      print('Error fetching citidfdfdes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching cities: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initiate();

  }

  Future<void> initiate() async {
    centerController.text = Utils.generateTimestampInMilliseconds();
    acessToken=(await Utils.getStringFromPrefs(Constant.TOKEN)!)!;
    email= (await Utils.getStringFromPrefs(Constant.EMAIL))!;
    print("object"+acessToken);
    print("object"+email);

    fetchCountries();
    fetchMemberList();
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
  }
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
          // filteredMemberList = memberList;
          isLoading = false;

          // Extracting names and adding them to a separate list
          List<String> names = [];
          for (var coordinator in coordinatorList) {
            coordinators.add(coordinator['name']);
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

  void submitEnquiry() async {
    print(alternativeMobileController.text);
    print("fgfgf");
    // Check if any required field is empty
    if (centerController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        emailController.text.isEmpty ||
        // addressController.text.isEmpty ||
        // professionController.text.isEmpty ||
        // qualificationController.text.isEmpty ||
        // ageGroupController.text.isEmpty ||
        // genderController.text.isEmpty ||

        sourceController.text.isEmpty) {
      Utils.showAlertDialog(context, "Please fill in all fields");
      return;
    }

    // Validate email format
    if (!Utils.isEmailValid(emailController.text)) {
      Utils.showAlertDialog(context, "Please enter a valid email!");
      return;
    }

    // Validate mobile numbers
    if (mobileController.text.length != 10) {
      Utils.showAlertDialog(context, "Enter a valid 10-digit mobile number!");
      return;
    }

    if (alternativeMobileController.text.length != 10) {
      Utils.showAlertDialog(context, "Enter a valid 10-digit alternative mobile number!");
      return;
    }

    if (mobileController.text == alternativeMobileController.text) {
      Utils.showAlertDialog(context, "Mobile numbers cannot be the same!");
      return;
    }

    // Fetch stored data
    String? response = await Utils.getStringFromPrefs(Constant.MEMBER_API);

    // Check if the mobile number is already in the system
    if (isMobileNumberFound(response!, mobileController.text)) {
      Utils.showAlertDialog(context, "Number already found!");
      return;
    }

    if (isMobileNumberFound(response, alternativeMobileController.text)) {
      Utils.showAlertDialog(context, "Alternative number already found!");
      return;
    }

    // Proceed with adding enquiry
    addEnquiry(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add New Enquiry',
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
                          labelText: 'Id No',
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
                        value: selectCenterController.text.isNotEmpty
                            ? selectCenterController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectCenterController.text = value!;
                          });
                        },
                        items: ['Salimar Bag', 'Ashok Vihar','Online'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Center',
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
                        controller: localityController,
                        decoration: InputDecoration(
                          labelText: 'Locality',
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
                        controller: dateController,
                        readOnly: true, // Prevent manual text entry
                        decoration: InputDecoration(
                          labelText: 'Select Date',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                dateController.text = formattedDate;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),

                      // TextFormField(
                      //   controller: professionController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Profession',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      // TextFormField(
                      //   controller: qualificationController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Qualification',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
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
                      // DropdownButtonFormField<String>(
                      //   value: ageGroupController.text.isNotEmpty
                      //       ? ageGroupController.text
                      //       : null,
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       ageGroupController.text = value!;
                      //     });
                      //   },
                      //   items: [
                      //     '1-5',
                      //     '6-10',
                      //     '11-15',
                      //     '16-20',
                      //     '21-25',
                      //     '26-30',
                      //     '31-35',
                      //     '36-40',
                      //     '41-45',
                      //     '46-50',
                      //     '51-55',
                      //     '56-60+'
                      //   ].map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: 'Select Age Group',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      // DropdownButtonFormField<String>(
                      //   value: genderController.text.isNotEmpty
                      //       ? genderController.text
                      //       : null,
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       genderController.text = value!;
                      //     });
                      //   },
                      //   items: ['Male', 'Female', 'Others'].map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: 'Select Gender',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: statusController.text.isNotEmpty
                            ? statusController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            statusController.text = value!;
                          });
                        },
                        items: ['Member', 'Enquiry'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Status',
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
                        value: callingStatusController.text.isNotEmpty
                            ? callingStatusController.text
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            callingStatusController.text = value!;
                          });
                        },
                        items: ['Call', 'Do Not Call', 'Only Message'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Calling Status',
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
                      // TextFormField(
                      //   controller: coordinatorController,
                      //   decoration: InputDecoration(
                      //     labelText: 'Coordinator',
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 13.0, horizontal: 10.0),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 15.0),
                      DropdownButtonFormField<String>(
                        value: selectedCoordinator.isNotEmpty &&
                            coordinators.contains(selectedCoordinator)
                            ? selectedCoordinator
                            : null,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCoordinator = value ?? '';


                            print("gbghbihfjvuhhuhgvbduhsi");
                          });
                        },
                        items: coordinators
                            .map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        ))
                            .toList(),
                        decoration: InputDecoration(
                          labelText: 'Select Coordinator',
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
                        value: sourceController.text.isNotEmpty ? sourceController.text : null,
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
                  onPressed: () {
                    submitEnquiry(); // No need to await a void function
                    print("Enquiry submitted successfully");
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
                  child: const Text(
                    'Submit',
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

  Future<void> addEnquiry(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);

    pd.show(msg: "Please Wait");
    String message = "";
    final Dio dio = Dio();
    // Adjust the API endpoint accordingly
    final data = {
      "center_id": centerController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "mobile": mobileController.text,
      "alternative": alternativeMobileController.text,
      "email": emailController.text,
      "country":selectedCountry,
      "state": selectedState,
      "city": selectedCity,
      "date": dateController.text,
      "calling_status": callingStatusController.text,
       "qualification":"dfgfgf",
      "locality": localityController.text,
      "profession": " wretgh",
      "status": statusController.text,
      "center": selectCenterController.text,
      // "address": addressController.text,
      // "profession": professionController.text,
      // "qualification": qualificationController.text,
      // "age_group": ageGroupController.text,
      // "gender": genderController.text,
      "cordinator": selectedCoordinator,
      "source": sourceController.text,
      "login_id": (await Utils.getStringFromPrefs(Constant.ROLL_ID)),
    };
    print(data);
    try {
      final response = await _dio.post(Constant.BASE_URL + "api/addenquiry", data: data);
      if (response.statusCode == 200) {
        pd.close(delay: 0);
        final jsonResponse = response.data;
        print(response.toString());
        Map<String, dynamic> responseMap = json.decode(response.toString());
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
      Utils.showAlertDialog(context, 'SOMETHING WENT WRONG !!$e');
      throw Exception('An error occurred during enquiry');
    }
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

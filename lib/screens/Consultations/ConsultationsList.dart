import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConsultationsList extends StatefulWidget {
  @override
  _ConsultationsListState createState() => _ConsultationsListState();
}

class _ConsultationsListState extends State<ConsultationsList> {
  late Future<Map<String, dynamic>> consultationDetails;
  String selectedDoctor = '';
  String selectedBranch = '';

  @override
  void initState() {
    super.initState();
    // Initialize the Future in initState
    consultationDetails = fetchConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'All Consultations',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14B3B4), Color(0xFF14B3B4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [

              ],
            ),
            Row(
              children: [

              ],
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: consultationDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading data'),
                    );
                  } else {
                    List<dynamic> consultationList = snapshot.data!['sales'];

                    // Filter consultationList based on selectedDoctor
                    if (selectedDoctor.isNotEmpty) {
                      consultationList = consultationList
                          .where((consultation) => consultation['doctor'] == selectedDoctor)
                          .toList();
                    }

                    // Filter consultationList based on selectedBranch
                    if (selectedBranch.isNotEmpty) {
                      consultationList = consultationList
                          .where((consultation) => consultation['branch'] == selectedBranch)
                          .toList();
                    }

                    return ListView.builder(
                      itemCount: consultationList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> consultation = consultationList[index];

                        return Column(
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildText('OPD No', consultation['opd_no'].toString()),
                                  _buildText('Date', consultation['date']),
                                  _buildText('Time', consultation['time']),
                                  _buildText('Age', consultation['age']),
                                  _buildText('Sex', consultation['sex']),
                                  _buildText('Name', consultation['name']),
                                  _buildText('Phone', consultation['phone']),
                                  _buildText('Address', consultation['address']),
                                  _buildText('Blood Group', consultation['blood_group']),
                                  _buildText('Doctor', consultation['doctor']),
                                  _buildText('Branch', consultation['branch']),
                                  _buildText('Present Complaint', consultation['present_complaint']),
                                  _buildText('Past History', consultation['past_history']),
                                  _buildText('Family History', consultation['family_history']),
                                  _buildText('Menstrual History', consultation['menstrual_history']),
                                  _buildText('Surgical Treatment History', consultation['surgical_tratment_history']),
                                  _buildText('Investigation Advised', consultation['investigation_advised']),
                                  _buildText('Treatment Advised', consultation['treatment_advised']),
                                  _buildText('Height', consultation['height']),
                                  _buildText('Weight', consultation['weight']),
                                  _buildText('Pulse', consultation['pulse']),
                                  _buildText('BP', consultation['bp']),
                                  _buildText('HR', consultation['hr']),
                                  _buildText('Temp', consultation['temp']),
                                  _buildText('Nadi', consultation['nadi']),
                                  _buildText('Digestion', consultation['digestion']),
                                  _buildText('Bowl', consultation['bowl']),
                                  _buildText('Urine', consultation['urine']),
                                  _buildText('Sleep', consultation['sleep']),
                                  _buildText('Hunger', consultation['hunger']),
                                ],
                              ),
                              onTap: () {
                                // Handle item click
                              },
                            ),
                            Divider(),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String title, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: TextStyle(color: Colors.white),
        ),
        Flexible(
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchConsultations() async {
    const apiEndpoint = 'https://clients.charumindworks.com/satya/api/OpdList';

    try {
      final response = await Dio().get(apiEndpoint);
      List<dynamic> filteredConsultations = response.data['sales'].toList();

      return {
        'status': 'success',
        'message': 'Consultations listing successfully.',
        'sales': filteredConsultations,
      };
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}

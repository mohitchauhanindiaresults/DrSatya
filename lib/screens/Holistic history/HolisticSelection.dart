import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:satya_new/screens/Sales/AddSaleForm.dart';
import 'package:satya_new/screens/Holistic%20history/AddHealthScore.dart';
import 'package:satya_new/screens/Holistic%20history/HelathForm.dart';
import 'package:satya_new/screens/Sales/SalesListing.dart';
import 'package:satya_new/screens/Sales/SalesSetting.dart';
import 'package:satya_new/utils/Constant.dart';
import 'package:satya_new/utils/Utils.dart';

class HolisticSelection extends StatefulWidget {
  @override
  _HolisticSelectionState createState() => _HolisticSelectionState();
}

class _HolisticSelectionState extends State<HolisticSelection> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> memberList = [];
  List<Map<String, dynamic>> filteredMemberList = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchMemberList();
  }

  Future<void> fetchMemberList() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
        "https://clients.charumindworks.com/satya/api/enquiry",
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        Utils.printLongString(jsonResponse.toString());
        Utils.saveStringToPrefs(Constant.MEMBER_API, response.toString());
        final data = jsonResponse['enquiry'];

        setState(() {
          memberList = List<Map<String, dynamic>>.from(data);
          filteredMemberList = List.from(memberList); // Initialize filtered list
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load members';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Choose Master Data From List',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [


        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                filterMemberList(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchMemberList();
              },
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : error.isNotEmpty
                  ? Center(child: Text(error))
                  : filteredMemberList.isEmpty
                  ? Center(child: Text('No members found'))
                  : ListView.builder(
                itemCount: filteredMemberList.length,
                itemBuilder: (context, index) {
                  final member = filteredMemberList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HealthForm(
                                    employeeId: member['id'],
                                  ),
                            ),
                          );
                        },
                        title: Text(
                          member['first_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text('Age Group: ${member['age_group']}'),
                            Text('Mobile: ${member['mobile']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
}

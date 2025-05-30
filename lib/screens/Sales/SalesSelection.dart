  import 'package:dio/dio.dart';
  import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
  import 'package:satya_new/screens/Sales/AddSaleForm.dart';
import 'package:satya_new/screens/Sales/SalesListing.dart';
  import 'package:satya_new/screens/Sales/SalesSetting.dart';
  import '../../utils/ApiInterceptor.dart';
import '../../utils/Constant.dart';
  import '../../utils/Utils.dart';
  import '../AddEnquiryScreen.dart';
  import '../UpdateEnquiryScreen.dart';
  class SalesSelection extends StatefulWidget {
    @override
    _SalesSelectionState createState() => _SalesSelectionState();
  }

  class _SalesSelectionState extends State<SalesSelection> {
    TextEditingController searchController = TextEditingController();
    List<Map<String, dynamic>> memberList = [];
    List<Map<String, dynamic>> filteredMemberList = [];
    bool isLoading = true;
    String error = '';
    final Dio _dio = ApiInterceptor.createDio(); // Use ApiInterceptor to create Dio instance

    @override
    void initState() {
      super.initState();
      fetchMemberList();
    }

    Future<void> fetchMemberList() async {
      try {
        final response = await _dio.get(
          "https://clients.charumindworks.com/satya/api/enquiry",
        );

        if (response.statusCode == 200) {
          final jsonResponse = response.data;
          Utils.printLongString(jsonResponse.toString());
          Utils.saveStringToPrefs(Constant.MEMBER_API, response.toString());
          // final data = jsonResponse['enquiry'];
          //  Filter out enquiries where followup_status is 'Closed'
          final List<dynamic> allEnquiries = jsonResponse['enquiry'] ?? [];
          final List<dynamic> filteredEnquiries = allEnquiries.where((e) {
            final status = e['followup_status']?.toString().toLowerCase();
            return status != 'closed';
          }).toList();

          setState(() {
            memberList = List<Map<String, dynamic>>.from(filteredEnquiries);
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
            'Sales',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SalesListing()
                  ),
                );
                // Add your settings button functionality here
              },
            ),
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
                decoration: InputDecoration (
                  labelText: 'Search To Create New Lead',
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
                            if(member['followup_status']!='Pending')
                            {
                              Fluttertoast.showToast(msg:"You have already running active lead", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white);
                              return;
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddSaleForm(employeeId: member['id'])));
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
                              Text('Sr No.: ${member['center_id']}'),
                              // RichText(
                              //   text: TextSpan(
                              //     children: [
                              //       // TextSpan(
                              //       //   text: 'Lead Status: ', // Regular text
                              //       //   style: TextStyle(color: Colors.black), // Color for regular text
                              //       // ),
                              //       // TextSpan(
                              //       //   text: '${member['followup_status'] ?? ''}',
                              //       //   style: TextStyle(
                              //       //     color: Utils.getLeadStatusColor(member['followup_status']),
                              //       //   ),
                              //       // ),
                              //     ],
                              //   ),
                              // ),

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
            (member['alternative'] != null && member['alternative'].toString().contains(query)) ||
            (member['first_name'] != null && member['first_name'].toString().toLowerCase().contains(query.toLowerCase())))
            .toList();
      });
    }
  }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:satya_new/screens/Billing/BillingSelection.dart';
import 'package:satya_new/screens/Sales/SalesListing.dart';
import 'package:satya_new/utils/Constant.dart';
import 'package:satya_new/utils/Utils.dart';
import '../../utils/ApiInterceptor.dart';

class AddNewFollowUpScreen extends StatefulWidget {
  final String salesId;
  final String centerId;
  AddNewFollowUpScreen({required this.salesId, required this.centerId});

  @override
  _AddNewFollowUpScreenState createState() => _AddNewFollowUpScreenState();
}

class _AddNewFollowUpScreenState extends State<AddNewFollowUpScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  String selectedAction = '';
  final Dio _dio = ApiInterceptor.createDio();
  bool isLoading = false;
  bool buttonVisibity=false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      setState(() {
        _timeController.text = DateFormat('HH:mm').format(dt);
      });
    }
  }

  Future<void> updateFollowUpStatus() async {
    setState(() {
      isLoading = true;
    });

    final formData = FormData.fromMap({
      'date': _dateController.text,
      'time': _timeController.text,
      'action_status': selectedAction,
      'remark': _remarkController.text,
      'center_id': widget.centerId,
      'sales_id': widget.salesId,
    });

    // Debug: Print actual form values
    formData.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });

    try {
      final response = await _dio.post(
        Constant.BASE_URL_2 + Constant.UPDATE_FOLLOW_UP,
        data: formData,
      );

      if (response.statusCode == 200 && response.data['status']=='success') {
        print('✅ Follow-up updated successfully: ${response.data}');
        Fluttertoast.showToast(msg: response.data['message'], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white);
        if(selectedAction=="Billing"){
          Utils.navigateToPage(context, BilllingSelection());
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => SalesListing()));

        }

      } else {
        Fluttertoast.showToast(msg: response.data['message'], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey, textColor: Colors.white);
        print('❌ Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('🚫 Error: $e');
    }finally{
      setState(() {
        isLoading = false;
      });

    }
  }


  void _handleSubmit() {

    if(selectedAction=="Next Follow Up"){
      if (
     _dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
      _remarkController.text.isEmpty ||
          selectedAction.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all fields')),
        );
        return;
      } else {
        updateFollowUpStatus();
      }


    }else{

      if (
      //_dateController.text.isEmpty ||
      //   _timeController.text.isEmpty ||
      _remarkController.text.isEmpty ||
          selectedAction.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all fields')),
        );
        return;
      } else {
        updateFollowUpStatus();
      }
    }


  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF14B3B4),
        title: Text(
          'Add New Follow Up',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Visibility(
                    visible: buttonVisibity,
                    child: TextField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        labelStyle: TextStyle(fontSize: 14),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Icon(Icons.calendar_today, size: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Visibility(
                    visible: buttonVisibity,
                    child: TextField(
                      controller: _timeController,
                      readOnly: true,
                      onTap: () => _selectTime(context),
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: 'Select Time',
                        labelStyle: TextStyle(fontSize: 14),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        suffixIcon: Icon(Icons.access_time, size: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _remarkController,
                    maxLines: 3,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Remark',
                      labelStyle: TextStyle(fontSize: 14),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedAction.isNotEmpty ? selectedAction : null,
                    decoration: InputDecoration(
                      labelText: 'Select Action',
                      labelStyle: TextStyle(fontSize: 14),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    items: <String>['Billing', 'Not Interested', 'Next Follow Up']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAction = newValue ?? '';
                        if(selectedAction=="Next Follow Up"){
                          buttonVisibity=true;
                        }else{
                          buttonVisibity=false;
                        }

                      });
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

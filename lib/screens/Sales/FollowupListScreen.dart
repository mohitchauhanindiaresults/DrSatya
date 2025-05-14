import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class FollowupListScreen extends StatefulWidget {
  final String saleId;

  const FollowupListScreen({super.key, required this.saleId});

  @override
  State<FollowupListScreen> createState() => _FollowupListScreenState();
}

class _FollowupListScreenState extends State<FollowupListScreen> {
  bool isLoading = true;
  List<dynamic> followups = [];
  String? error;

  final Color themeColor = const Color(0xFF14B3B4);

  @override
  void initState() {
    super.initState();
    fetchFollowups();
  }

  Future<void> fetchFollowups() async {
    try {
      final response = await Dio().get(
        'https://clients.charumindworks.com/satya/api/followuplist',
        queryParameters: {'sales_id': widget.saleId},
      );

      if (response.data['status'] == 'success') {
        setState(() {
          followups = response.data['members'];
          isLoading = false;
        });
      } else {
        setState(() {
          error = response.data['message'] ?? 'Failed to load data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Something went wrong!';
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow-up History', style: TextStyle(fontSize: 16)),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!, style: const TextStyle(fontSize: 14)))
          : followups.isEmpty
          ? const Center(child: Text('No follow-ups found.'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: followups.length,
        itemBuilder: (context, index) {
          final item = followups[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Date:', item['date'] ?? 'N/A'),
                  _buildRow('Time:', _formatTime(item['time'] ?? '')),
                  _buildRow('Initial Datetime:', _formatDateTime(item['initial_datetime'] ?? '')),
              //    _buildRow('Action:', item['action'] ?? 'N/A'),
                  _buildRow('Status:', item['status'] ?? 'N/A'),
                  _buildRow('Action Status:', item['action_status'] ?? 'N/A'),
                  _buildRow('Remark:', item['remark'] ?? 'N/A'),
                ],


              ),
            ),
          );
        },
      ),
    );
  }
  String _formatTime(String time24) {
    try {
      final time = DateFormat("HH:mm").parse(time24);
      return DateFormat("hh:mm a").format(time);
    } catch (_) {
      return time24;
    }
  }

  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(dateTimeStr);
      return DateFormat("yyyy-MM-dd hh:mm a").format(dateTime);
    } catch (_) {
      return dateTimeStr;
    }
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black),
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(fontWeight: FontWeight.bold, color: themeColor),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

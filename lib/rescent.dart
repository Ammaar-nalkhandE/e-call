import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'get_contacts.dart';




class CallLogs extends StatefulWidget {

  @override
  _CallLogsState createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  List<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  Future<void> _getCallLogs() async {
    Iterable<CallLogEntry> callLogs = await CallLog.get();
    setState(() {
      _callLogs = callLogs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call History'),
      ),
      body: ListView.builder(
        itemCount: _callLogs.length,
        itemBuilder: (context, index) {
          CallLogEntry entry = _callLogs[index];
          return ListTile(
            onTap: () {
              String phoneNumber = entry.number ?? ""; // Assign an empty string if entry.number is null
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dialer(phoneNumber: phoneNumber)),
              );
            },

            title: Text('${entry.name}\t ${entry.number}'),
            subtitle: Text('${_getCallType(entry.callType ?? CallType.unknown)}\tDate: ${entry.timestamp}'),
          );
        },
      ),
    );
  }

  String _getCallType(CallType callType) {
    switch (callType) {
      case CallType.incoming:
        return 'Incoming';
      case CallType.outgoing:
        return 'Outgoing';
      case CallType.missed:
        return 'Missed';
      case CallType.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }
}

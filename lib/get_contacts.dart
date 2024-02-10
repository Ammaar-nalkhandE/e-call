import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Contacts(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? contacts;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      print(contacts);
      setState(() {});
    }
  }

  List<Contact>? _searchContacts(String query) {
    if (query.isEmpty) {
      return contacts;
    } else {
      return contacts
          ?.where((contact) =>
      contact.name.first.toLowerCase().contains(query.toLowerCase()) ||
          contact.name.last.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search contacts',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Update the UI when search query changes
              },
            ),
          ),
          Expanded(
            child: contacts == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _searchContacts(_searchController.text)?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Uint8List? image =
                    _searchContacts(_searchController.text)?[index].photo;
                String? num;
                if ((_searchContacts(_searchController.text)?[index].phones.isNotEmpty == true)) {
                  num = (_searchContacts(_searchController.text)?[index]
                      .phones.first.number);
                } else {
                  num = "--";
                }
                return ListTile(
                  leading: (image == null)
                      ? const CircleAvatar(child: Icon(Icons.person))
                      : CircleAvatar(backgroundImage: MemoryImage(image)),
                  title: Text(
                      "${_searchContacts(_searchController.text)?[index].name.first} ${_searchContacts(_searchController.text)?[index].name.last}"),
                  subtitle: Text(num!),
                  onTap: () {
                    if (_searchContacts(_searchController.text)![index].phones.isNotEmpty) {
                      String phoneNumber =
                          _searchContacts(_searchController.text)![index].phones.first.number;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dialer(
                              phoneNumber: phoneNumber,
                            )),
                      );
                    }
                  },
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}

class Dialer extends StatefulWidget {
  final String phoneNumber;

  const Dialer({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _DialerState createState() => _DialerState();
}

class _DialerState extends State<Dialer> {
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _phoneNumber = widget.phoneNumber;
  }

  void _addToNumber(String number) {
    setState(() {
      _phoneNumber += number;
    });
  }

  void _removeLastDigit() {
    setState(() {
      if (_phoneNumber.isNotEmpty) {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      }
    });
  }

  void _makeCall() async {
    if (_phoneNumber.isNotEmpty) {
      await FlutterPhoneDirectCaller.callNumber(_phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      controller: TextEditingController(text: _phoneNumber),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _removeLastDigit,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '⌫',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('1'),
                    _buildNumberButton('2'),
                    _buildNumberButton('3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('4'),
                    _buildNumberButton('5'),
                    _buildNumberButton('6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('7'),
                    _buildNumberButton('8'),
                    _buildNumberButton('9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('*'),
                    _buildNumberButton('0'),
                    _buildNumberButton('#'),
                  ],
                ),
                ElevatedButton(
                  onPressed: _makeCall,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Call',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _addToNumber(number),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          number,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

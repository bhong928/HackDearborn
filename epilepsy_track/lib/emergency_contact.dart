import 'package:flutter/material.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({Key? key}) : super(key: key);

  @override
  _EmergencyContactState createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Momma'),
            subtitle: Text('Mother'),
            trailing: Icon(Icons.phone),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Padre'),
            subtitle: Text('Father'),
            trailing: Icon(Icons.phone),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Bob Smith'),
            subtitle: Text('Friend'),
            trailing: Icon(Icons.phone),
          ),
        ],
      ),
    );
  }
}

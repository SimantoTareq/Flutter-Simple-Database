import 'package:database/db_helper/mydb_helper.dart';
import 'package:database/model/contact.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      label: Text('Name'),
                      hintText: 'Please Enter Name',
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      label: Text('Phone'),
                      hintText: 'Please Enter Number',
                      prefixIcon: Icon(Icons.call)),
                ),
                SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await MyDbHelper.CreateContact(Contact(
                          name: _nameController.text,
                          phone: _phoneController.text));

                      Navigator.of(context).pop();
                    },
                    child: Text('Save Contact'))
              ],
            ),
          )),
    );
  }
}

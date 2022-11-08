import 'dart:math';

import 'package:database/db_helper/mydb_helper.dart';
import 'package:database/main.dart';
import 'package:database/model/contact.dart';
import 'package:database/widgets/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Demo extends StatefulWidget {
  //const Demo({super.key});
  Contact? contact;

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: MyDbHelper.readContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Loading...'),
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No data'),
                )
              : ListView(
                  children: snapshot.data!
                      .map((e) => Center(
                            child: ListTile(
                              title: Text(e.name),
                              subtitle: Text(e.phone),
                              trailing: IconButton(
                                  onPressed: () async {
                                    await MyDbHelper.deleteContact(e.id!);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          ))
                      .toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_c) => NewContact()));

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

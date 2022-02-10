
import 'package:flutter/material.dart';
import 'package:flutter_crud/dbhelper/contact_database.dart';
import 'package:flutter_crud/model/contact.dart';
import 'package:flutter_crud/widget/contact_details.dart';
import 'package:flutter_crud/widget/new_contact.dart';


class AllContacts extends StatefulWidget {
  const AllContacts({Key? key}) : super(key: key);

  @override
  _AllContactsState createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {


  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    print("init");
    loadData();
  }

  Future loadData() async {
    contacts = await ContactDatabase.instance.readAllContacts();

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          actions: [settingButton()],
        ),
        body: (contacts != null && contacts.isNotEmpty)
            ? ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ContactDetails(contacts[index])),

                    );
                  },
                  leading: Image.asset('assets/images/virat.jpg'),
                  title: Text(
                    "${contacts[index].contactName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  subtitle: Text(
                    "${contacts[index].contactNumber}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple),
                  ),
                  trailing: Text(
                    "${contacts[index].contactAddress}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.brown),
                  ),
                ),
              );
            })
            : Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewContact()),
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(),
      ),
    );
  }

  Widget getWidget(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }

  Widget settingButton() => IconButton(
      icon: Icon(Icons.settings),
      onPressed: () async {
        //refreshNote();
      });

  Future delete(int? id) async {
    await ContactDatabase.instance.delete(id!);
  }



}

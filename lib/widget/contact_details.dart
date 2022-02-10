import 'package:flutter/material.dart';
import 'package:flutter_crud/dbhelper/contact_database.dart';
import 'package:flutter_crud/model/contact.dart';
import 'package:flutter_crud/widget/all_contact.dart';
import 'package:flutter_crud/widget/edit_contact.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactDetails extends StatefulWidget {
  //const ContactDetails({Key? key}) : super(key: key);


  Contact contact;

  ContactDetails(this.contact);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contact Details"),
          actions: [editButton(), deleteButton()],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Card(
                child: Image.asset('assets/images/virat.jpg'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "${widget.contact.contactName}",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "${widget.contact.contactAddress}",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "${widget.contact.contactNumber}",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final phoneNumber = "${widget.contact.contactNumber}";
            final url = 'tel:$phoneNumber';

            if (await canLaunch(url)) {
              await launch(url);
            }
          },
          child: const Icon(Icons.phone),
        ),
      ),
    );
  }


  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditContact(widget.contact)),
        );
      });

  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      delete(widget.contact.id);
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllContacts()),
      );

      Navigator.of(context).pop();
    },
  );

  Widget callButton() => IconButton(
    icon: Icon(Icons.phone),
    onPressed: () async {
      final phoneNumber = "${widget.contact.contactNumber}";
      final url = 'tel:$phoneNumber';

      if (await canLaunch(url)) {
        await launch(url);
      }

      // Navigator.of(context).pop();
    },
  );

  Future delete(int? id) async {
    await ContactDatabase.instance.delete(id!);
  }



}

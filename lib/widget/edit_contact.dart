import 'package:flutter/material.dart';
import 'package:flutter_crud/dbhelper/contact_database.dart';
import 'package:flutter_crud/model/contact.dart';
import 'package:flutter_crud/widget/all_contact.dart';



class EditContact extends StatefulWidget {


  late Contact contact;

  EditContact(this.contact);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {


  TextEditingController textEditingControllerContactName =
  new TextEditingController();
  TextEditingController textEditingControllerContactNumber =
  new TextEditingController();
  TextEditingController textEditingControllerContactAddress =
  new TextEditingController();

  late String name;
  late String number;
  late String address;

  @override
  void initState() {
    super.initState();
    textEditingControllerContactName.text = widget.contact.contactName;
    textEditingControllerContactNumber.text = widget.contact.contactNumber;
    textEditingControllerContactAddress.text = widget.contact.contactAddress;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
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
        child: new Form(
          child: new Column(
            children: [
              new Padding(padding: EdgeInsets.only(top: 30.0)),
              new TextFormField(
                controller: textEditingControllerContactName,
                decoration: InputDecoration(hintText: "Name"),
              ),
              new TextFormField(
                controller: textEditingControllerContactNumber,
                decoration: InputDecoration(hintText: "Mobile No."),
              ),
              new TextFormField(
                controller: textEditingControllerContactAddress,
                decoration: InputDecoration(hintText: "Address"),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: () {
                  print(widget.contact.contactName);

                  print(widget.contact.id);

                  upDate();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllContacts()),
                  );
                },
                color: Colors.deepOrange,
                child: Text(
                  "SAVE CHANGES",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ) ;
  }

  Future upDate() async {
    final friend22 = widget.contact.copy(
      contactName: textEditingControllerContactName.text,
      contactNumber: textEditingControllerContactNumber.text,
      contactAddress: textEditingControllerContactAddress.text,
    );

    await ContactDatabase.instance.update(friend22);
  }



}


import 'package:flutter/material.dart';
import 'package:flutter_crud/dbhelper/contact_database.dart';
import 'package:flutter_crud/model/contact.dart';
import 'package:flutter_crud/widget/all_contact.dart';


class NewContact extends StatefulWidget {
  const NewContact({Key? key}) : super(key: key);

  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {

  TextEditingController textEditingControllerContactName = new TextEditingController();
  TextEditingController textEditingControllerContactNumber = new TextEditingController();
  TextEditingController textEditingControllerContactAddress = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create new contact"),

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

        child: Form(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(30.0)),
              TextFormField(controller: textEditingControllerContactName,decoration: InputDecoration(hintText : "Name"),),
              TextFormField(controller: textEditingControllerContactNumber,decoration: InputDecoration(hintText: "Mobile No."),),
              TextFormField(controller: textEditingControllerContactAddress,decoration: InputDecoration(hintText : "Address"),),

              SizedBox(height: 13.0,),
              RaisedButton(
                color: Colors.green
                ,onPressed: (){

                final contact = new Contact(contactName: "${textEditingControllerContactName.text}", contactNumber: "${textEditingControllerContactNumber.text}", contactAddress: "${textEditingControllerContactAddress.text}");


                ContactDatabase.instance.create(contact);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllContacts()),);


              },
                child: Text("SAVE",style: TextStyle(color: Colors.white),),
              )

            ],



          ),
        ),
      ),
    );
  }
}

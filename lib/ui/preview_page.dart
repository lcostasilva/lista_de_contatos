import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lista_de_contatos/helpers/contact_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/helpers/contact_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_page.dart';

class PreviewPage extends StatefulWidget {
  final Contact contact;
  PreviewPage({this.contact});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {



  final _nameFocus = FocusNode();
  ContactHelper helper = ContactHelper();

  Contact _editedContact;

  bool _userEdited = false;

  @override
  void initState() {
    super.initState();
    if(widget.contact == null){
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());


    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contato"),
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _editContact(contact: _editedContact);
          },
          child: Icon(Icons.edit),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 0.9],
                      colors: [
                        Colors.red,
                        Colors.deepOrange.shade300
                      ]
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        child: GestureDetector(
                          child: Icon(Icons.call, size: 30.0,),
                          onTap: (){
                            launch("tel:${_editedContact.phone}");
                          },
                        ),
                        minRadius: 30.0,
                        backgroundColor: Colors.red.shade600,
                      ),
                      CircleAvatar(
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrange.shade300,
                            backgroundImage: _editedContact.img != null ?
                            FileImage(File(_editedContact.img)) :
                            AssetImage("images/person.png"),
                            minRadius: 50.0,
                          ),
                        minRadius: 60.0,
                        backgroundColor: Colors.deepOrange.shade300,
                      ),
                      CircleAvatar(
                        child: GestureDetector(
                          child: Icon(Icons.message, size: 30.0,),
                          onTap: (){
                            launch("mailto:${_editedContact.email}");
                          },
                        ),
                        minRadius: 30.0,
                        backgroundColor: Colors.red.shade600,
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(_editedContact.name, style: TextStyle(fontSize: 22.0, color: Colors.white),),
                ],
              ),
            ),
            ListTile(
              title: Text("Email", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
              subtitle: Text(_editedContact.email, style: TextStyle(fontSize: 18.0),),
            ),
            Divider(),
            ListTile(
              title: Text("Telefone", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
              subtitle: Text(_editedContact.phone, style: TextStyle(fontSize: 18.0),),
            ),
            Divider(),
          ],
        ),
      ),

    );
  }

  Future<bool> _requestPop(){
    if(_userEdited) {
      Navigator.pop(context, _editedContact);
    } else {
      return Future.value(true);
    }

  }

  void _editContact({Contact contact}) async{

    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact,))
    );
    if(recContact != null){
      _editedContact = recContact;
      _userEdited = true;
    }
  }



}


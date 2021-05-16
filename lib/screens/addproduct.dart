import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  final ImagePicker _picker=ImagePicker();
  PickedFile _image;
  CollectionReference users= FirebaseFirestore.instance.collection('items');
  final firestoreInstance = FirebaseFirestore.instance;
  String itemname="";
  String description="";
  String price="";
  String quantity="";

  void pic(ImageSource source,int imageNumber) async {
    final PickedFile = await _picker.getImage(source: source);
    switch(imageNumber){
      case 1:  setState(() => _image = PickedFile);
      break;
    }
  }

  void _saveForm() {
    setState(() {
      _isValid = _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: ListView(
          children:<Widget>[
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,0,0),
                      child: Text('Add Images',style: TextStyle(fontSize:15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: Container(
                        height: 200,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.5),width: 2.5)
                            ),
                            height: 100,
                            child: _displayChild()
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (val){setState(()=>itemname=val);},
                      decoration: InputDecoration(
                        hintText: 'Enter your the name of the product',
                        labelText: 'Name',
                      ),
                      validator:(value) {
                        if (value.isEmpty) {
                        return 'This field is required';
                        }return null;
                      }
                    ),
                    TextFormField(
                        onChanged: (val){setState(()=>description=val);},
                        decoration: InputDecoration(
                          hintText: 'Enter the descrption of the product',
                          labelText: 'Description',
                        ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }return null;
                        }
                    ),
                    TextFormField(
                        onChanged: (val){setState(()=>price=val);},
                      decoration: InputDecoration(
                        hintText: 'Enter the price of the product',
                        labelText: 'Price',
                      ),
                      validator:(value) {
                        if (value.isEmpty) {
                        return 'This field is required';
                        }return null;
                      }
                    ),
                    TextFormField(
                        onChanged: (val){setState(()=>quantity=val);},
                      decoration: InputDecoration(
                        hintText: 'Enter the quantity of the product',
                        labelText: 'Quantity',
                      ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }return null;
                        }
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 40.0),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text('Add item'),
                          onPressed: (){
                            _saveForm();
                            add();
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg:'Item added successfully');
                          },
                        )),
                  ],
                ),
          ),]
        ),
      ),
    );
  }

  Widget _displayChild() {
    if (_image == null) {
      return FlatButton(
        minWidth: MediaQuery.of(context).size.width*0.25,
        onPressed: (){ pic(ImageSource.gallery,1);},
          child: Center(child: Icon(Icons.add, color: Colors.grey,)));
    } else {
      return Image.file(File(_image.path),fit: BoxFit.fill,);
    }
  }

  void add(){
    String imgUrl;
    final FirebaseStorage storage= FirebaseStorage.instance;
    final String picture= "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task= storage.ref().child(picture).putFile(File(_image.path));


    CollectionReference users= FirebaseFirestore.instance.collection('items');
    final firestoreInstance = FirebaseFirestore.instance;

    firestoreInstance.collection("items").add(
        {
          "itemname" : itemname,
          "description" : description,
          "price" : price,
          "quantity" : quantity,
          "picture": "gs://eshopke-9f17f.appspot.com/1620685984121$picture",

        });
  }
}

import 'package:eshopkeseller/business_logic/user_provider.dart';
import 'package:eshopkeseller/database/items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DispItems extends StatefulWidget {
  String label;
  DispItems({this.label});

  @override
  _DispItemsState createState() => _DispItemsState();
}

class _DispItemsState extends State<DispItems> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  initUser()async{
    _user= await _auth.currentUser;
  }

  @override
  void initState() {
    ItemNotifier itemNotifier= Provider.of<ItemNotifier>(context,listen: false);
    getItems(itemNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserProvider>(context);
    ItemNotifier itemNotifier= Provider.of<ItemNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Navigator.of(context).pushNamed('/cart');
          }),
        ],),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GridView.builder(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    elevation: 10,
                    color: Colors.white,
                    child: InkWell(
                      child: GridTile(
                        child: Image.asset('assets/items/${itemNotifier.item_list[index].itemname}.jpg'),
                        footer: Container(
                          color: Colors.white70,
                          child: ListTile(
                            leading: Text(itemNotifier.item_list[index].itemname,textAlign: TextAlign.left,),
                            title: Text("Ksh ${itemNotifier.item_list[index].price}",textAlign: TextAlign.right,),
                          ),
                        ),
                      ),
                    ),
                  );

                },
                itemCount: itemNotifier.item_list.length),
          ),
        ],
      ) ,
    );
  }
}

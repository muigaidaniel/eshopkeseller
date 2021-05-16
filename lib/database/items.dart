import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ItemNotifier with ChangeNotifier{
  List<Item> _item_list= [];
  Item _currentItem;
  UnmodifiableListView<Item> get item_list=> UnmodifiableListView(_item_list);
  Item get currentItem => _currentItem;

  set item_list(List<Item> item_list){
    _item_list= item_list;
    notifyListeners();
  }
  set currentItem(Item item){
    _currentItem= item;
    notifyListeners();
  }
}

class Item{
  String id;
  String itemname;
  String picture;
  String price;
  String description;
  String quantity;

  Item.fromMap(Map<String, dynamic>data){
    itemname=data['itemname'];
    price=data['price'];
    description=data['description'];
    picture=data['picture'];
    quantity=data['quantity'];
  }

}

getItems(ItemNotifier itemNotifier)async{
  QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('items').get();
  List<Item> _item_list=[];
  snapshot.docs.forEach((doc) {
    Item item= Item.fromMap(doc.data());
    _item_list.add(item);
  });
  itemNotifier.item_list=_item_list;

}

import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final cart_itemname;
  final cart_itempicture;
  final cart_itemprice;
  CartItem({this.cart_itemname,this.cart_itempicture,this.cart_itemprice});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cart_itempicture,width: 80,),
        title: Text(cart_itemname),
        subtitle: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Number:')),
                Expanded(child: Text('Cost:')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
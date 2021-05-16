import 'package:eshopkeseller/screens/items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eshopkeseller/business_logic/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _products=0;
  int _instock=0;
  int _sold=0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  initUser()async{
    _user= await _auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Dashboard'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("user.user.displayName"),
              accountEmail: Text("user.user.email"),
              //currentAccountPicture: Image.network("user.user.photoURL")
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home)
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('Favourites'),
                    leading: Icon(Icons.favorite)
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('Orders'),
                    leading: Icon(Icons.shopping_bag)
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('My account'),
                    leading: Icon(Icons.person)
                )
            ),
            InkWell(
                onTap: (){
                  user.signOut();
                },
                child: ListTile(
                    title: Text('Log out'),
                    leading: Icon(Icons.logout)
                )
            ),
            Divider(),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings)
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text('Help'),
                    leading: Icon(Icons.help)
                )
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              subtitle: FlatButton(
                onPressed: null,
                child: Text('Ksh 0',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Theme.of(context).primaryColor)),
              ),
              title: Text(
                'Total Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: ListTile(
                  title: FlatButton.icon(
                      onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {return DispItems();}));},
                      icon: Icon(Icons.track_changes),
                      label: Text("Products")),
                  subtitle: Text(
                    '${_products?.toString()??"0"}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme
                        .of(context)
                        .accentColor, fontSize: 60.0),
                  )),
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("In stock")),
                        subtitle: Text(
                          '${_instock?.toString()??"0"}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme
                              .of(context)
                              .accentColor, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.tag_faces),
                            label: Text("Sold")),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme
                              .of(context)
                              .accentColor, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text("Visits")),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme
                              .of(context)
                              .accentColor, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.shopping_cart),
                            label: Text("Orders")),
                        subtitle: Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme
                              .of(context)
                              .accentColor, fontSize: 60.0),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'addproduct');
          setState(() {
            _products++;
            _instock++;
          });
        },
      ),);
  }
}
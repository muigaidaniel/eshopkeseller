import 'package:eshopkeseller/components/navbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text('Dashboard'),
        backgroundColor: Theme.of(context).accentColor,
      ),
      drawer: Navbar(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              subtitle: FlatButton(
                onPressed: null,
                child: Text('Ksh. 12,000',
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
                      onPressed: null,
                      icon: Icon(Icons.track_changes),
                      label: Text("Producs")),
                  subtitle: Text(
                    '120',
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
                          '23',
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
                          '13',
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
                          '7',
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
                          '5',
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
        },
      ),);
  }
}
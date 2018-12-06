import 'package:flutter/material.dart';

class KurikulumDetailScreen extends StatelessWidget {
  final int id;

  const KurikulumDetailScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurikulum Detail"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                decoration: const BoxDecoration(color: Colors.blueAccent),
              ),
              flex: 1,
            ),
            new Expanded(
              child: DefaultTabController( 
                length: 5,
                child: Scaffold(
                  appBar: AppBar(
                    flexibleSpace: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        new TabBar(
                          tabs: [
                            new Tab(icon: new Icon(Icons.directions_car)),
                            new Tab(icon: new Icon(Icons.directions_transit)),
                            new Tab(icon: new Icon(Icons.directions_bike)),
                            new Tab(icon: new Icon(Icons.directions_transit)),
                            new Tab(icon: new Icon(Icons.directions_bike)),
                          ],
                        ),
                      ],
                    ),
                    leading: new Container(),
                  ),
                )
              ),
              flex: 4,
            ),
          ],
        )  
      ),
    );
  }
}

/*
        RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            Navigator.pop(context);
          },
          child: Text('Kurikulum Id ' + id.toString()),
        ),
        */
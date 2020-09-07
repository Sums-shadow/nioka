import 'package:nioka/constante.dart';

import './game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Sums", style: TextStyle(fontSize: 10),)],),
      body: InkWell(
        onTap: ()=>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GamePage())),
              child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/snake.jfif'),

              SizedBox(height: 50.0),

              Text('Bienvenu sur Nokia', style: TextStyle(color: Colors.white, fontSize: 40.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text('Taper pour commencer', style: TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), textAlign: TextAlign.center),

           
            ],
          ),
        ),
      )
    );
  }
}
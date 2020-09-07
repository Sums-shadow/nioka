import 'package:avatar_glow/avatar_glow.dart';
import 'package:nioka/bd.dart';
import 'package:nioka/constante.dart';
import 'package:nioka/model.dart';
import 'package:nioka/score.dart';

import './game_page.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final int score;
  TextEditingController nom = TextEditingController();
  NokiaBd bd = NokiaBd();
  GameOver({this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        floatingActionButton:FloatingActionButton(
            onPressed: () {
             bd.addScore(new NokiaModel(
                  id: null, nom: nom.text, score: score.toString()));
              print("insertion reussi ");
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Score()));
            },
            child: Icon(Icons.add, color: color1),
            backgroundColor: Colors.white,
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Partie Terminé',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1.5, -1.5),
                            color: Colors.black),
                        Shadow(
                            // bottomRight
                            offset: Offset(1.5, -1.5),
                            color: Colors.black),
                        Shadow(
                            // topRight
                            offset: Offset(1.5, 1.5),
                            color: Colors.black),
                        Shadow(
                            // topLeft
                            offset: Offset(-1.5, 1.5),
                            color: Colors.black),
                      ])),
              SizedBox(height: 50.0),
              Text('Votre Score: $score',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              SizedBox(height: 50.0),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Votre nom:",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: 170,
                      child: TextField(
                        controller: nom,
                        autofocus: true,
                        maxLength: 50,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          hoverColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

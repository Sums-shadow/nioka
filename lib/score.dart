import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nioka/bd.dart';
import 'package:nioka/constante.dart';
import 'package:nioka/model.dart';

import 'game_page.dart';

class Score extends StatefulWidget {
  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  NokiaBd bd = NokiaBd();
  List<NokiaModel> data;
  init()async {
await bd.fetchScore().then((value){
  data = value;
});
   setState(() {
     data=data;
   });
      print(data);
    print(data[0]);
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        glowColor: Colors.blue,
        endRadius: 90.0,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => GamePage()));
          },
          child: Icon(Icons.refresh, color: color1),
          backgroundColor: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text("Score du jeux"),
        centerTitle: true,
        backgroundColor: color1,
      ),
      backgroundColor: color1,
      body: data == null
          ? Center(
              child: Text(
                "Pas de score enregistrer",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].toString()),
            );
          }),
    );
  }
}

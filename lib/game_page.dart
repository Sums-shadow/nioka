import 'dart:async';
import 'dart:math';

import 'package:nioka/constante.dart';

import './game_over.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {

  int score_jeux;
  bool _aCommencer;
  Animation niokaAnimation;
  AnimationController niokaController;
  List nioka = [404, 405, 406, 407];
  final int numCarreau = 500;
  final Duration _duration = Duration(milliseconds: 250);
  final int tailleCreau = 20;
  String directionNioka;
  int niokaFoodPosition;
  Random _random = new Random();

  @override
  void initState() {
    super.initState();
    initialisation_jeux();
  }

  void initialisation_jeux() {
    score_jeux = 0;
    directionNioka = 'RIGHT';
    _aCommencer = true;
    do {
      niokaFoodPosition = _random.nextInt(numCarreau);
    } while(nioka.contains(niokaFoodPosition));
    niokaController = AnimationController(vsync: this, duration: _duration);
    niokaAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: niokaController);
  }

  void debutJeux() {
    Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
      _updateSnake();
      if(_aCommencer) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < nioka.length - 1; i++) if (nioka.last == nioka[i]) return true;
    return false;
  }

  void _updateSnake() {
    if(!_aCommencer) {
      setState(() {
        score_jeux = (nioka.length - 4) * 100;
        switch (directionNioka) {
          case 'BAS':
            if (nioka.last > numCarreau) nioka.add(nioka.last + tailleCreau - (numCarreau + tailleCreau));
            else nioka.add(nioka.last + tailleCreau);
            break;
          case 'UP':
            if (nioka.last < tailleCreau) nioka.add(nioka.last - tailleCreau + (numCarreau + tailleCreau));
            else nioka.add(nioka.last - tailleCreau);
            break;
          case 'RIGHT':
            if ((nioka.last + 1) % tailleCreau == 0) nioka.add(nioka.last + 1 - tailleCreau);
            else nioka.add(nioka.last + 1);
            break;
          case 'LEFT':
            if ((nioka.last) % tailleCreau == 0) nioka.add(nioka.last - 1 + tailleCreau);
            else nioka.add(nioka.last - 1);
        }

        if (nioka.last != niokaFoodPosition) nioka.removeAt(0);
        else {
          do {
            niokaFoodPosition = _random.nextInt(numCarreau);
          } while (nioka.contains(niokaFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _aCommencer = !_aCommencer;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GameOver(score: score_jeux)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NIOKA', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        centerTitle: false,
        backgroundColor: color1,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Score: $score_jeux', style: TextStyle(fontSize: 16.0)),
            )
          ),
          IconButton(icon: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: niokaAnimation), onPressed:  () {
          setState(() {
            if(_aCommencer) niokaController.forward();
            else niokaController.reverse();
            _aCommencer = !_aCommencer;
            debutJeux();
          });
        },)
        ],
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (drag) {
            if (drag.delta.dy > 0 && directionNioka != 'UP') directionNioka = 'BAS';
            else if (drag.delta.dy < 0 && directionNioka != 'BAS') directionNioka = 'UP';
          },
          onHorizontalDragUpdate: (drag) {
            if (drag.delta.dx > 0 && directionNioka != 'LEFT') directionNioka = 'RIGHT';
            else if (drag.delta.dx < 0 && directionNioka != 'RIGHT')  directionNioka = 'LEFT';
          },
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: tailleCreau + numCarreau,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: tailleCreau),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    color: Colors.transparent,
                    padding: nioka.contains(index) ? EdgeInsets.all(1) : EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: index == niokaFoodPosition || index == nioka.last ? BorderRadius.circular(7) : nioka.contains(index) ? BorderRadius.circular(2.5) : BorderRadius.circular(1),
                      child: Container(
                        color: nioka.contains(index) ? Colors.white : index == niokaFoodPosition ? color1 : Colors.black
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

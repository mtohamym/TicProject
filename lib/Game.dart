import 'package:flutter/cupertino.dart';
import 'package:tic/constants.dart';
import 'package:flutter/material.dart';



class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool oTrun = true;
  List<String> display = ['', '', '', '', '', '', '', '', ''];
  int xScore = 0;
  int oScore = 0;
  int counter = 0;
  var ScoreStyle = TextStyle(color: Colors.white, fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player X', style: ScoreStyle),
                        Text(xScore.toString(), style: ScoreStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Player O', style: ScoreStyle),
                        Text(oScore.toString(), style: ScoreStyle),
                      ],
                    ),
                  ),
                ],
              ),
              //color: Colors.grey,
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[800])),
                        child: Center(
                          child: Text(
                            display[index],
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTrun && display[index] == '') {
        display[index] = 'O';
      } else if (!oTrun && display[index] == '') {
        display[index] = 'X';
      }
      oTrun = !oTrun;
      counter += 1;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // checks 1st row
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      _showWinner(display[0]);
    }

    // checks 2nd row
    if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      _showWinner(display[3]);
    }

    // checks 3rd row
    if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      _showWinner(display[6]);
    }

    // checks 1st column
    if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      _showWinner(display[0]);
    }

    // checks 2nd column
    if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      _showWinner(display[1]);
    }

    // checks 3rd column
    if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      _showWinner(display[2]);
    }

    // checks diagonal
    if (display[6] == display[4] &&
        display[6] == display[2] &&
        display[6] != '') {
      _showWinner(display[6]);
    }

    // checks diagonal
    if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      _showWinner(display[0]);
    }
    if(counter == 9){
      _showDraw();
      counter =0;
    }

  }

  void _showWinner(String Win) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("winner " + Win),
            actions: [
              FlatButton(
                child: Text('Reset Game'),
                onPressed: (){
                _ResetGmae();
                Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (Win == 'O') {
      oScore += 1;
    } else if (Win == 'X') {
      xScore += 1;
    }
  }

  void _ResetGmae() {
    setState(() {
      for (int i = 0 ; i < 9 ; i++){
        display[i] = '';
      }
    });

  }

  void _showDraw() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw "),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: (){
                  _ResetGmae();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

  }
}

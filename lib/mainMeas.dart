import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// --- Main program ------------------------------------------------------------
void main() => runApp(MaterialApp(
  home: HomeMeasurement(),
));



// --- Stateless widget to use hot reload --------------------------------------
class HomeMeasurement extends StatefulWidget {
  @override
  _HomeMeasurementState createState() => _HomeMeasurementState();
}

class _HomeMeasurementState extends State<HomeMeasurement> {

  int thresholdvalue = 43;
  String filename = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      // --- App Bar at the top ------------------------------------------------
      appBar: AppBar(
        title: Text('Measurement Screen'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[700],
      ),





      // --- The Body ----------------------------------------------------------
      // --- Zeilen erstellen --------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          // --- Zeile 1: Input ------------------------------------------------
          Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey[500],
              child: Column(
                children: <Widget>[
                  Text(
                    'INPUT',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      //color: Colors.cyanAccent[700],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('Set threshold value:'),
                      ),
                      Text('$thresholdvalue'),
                      Text(' dB '),
                      RaisedButton(
                        onPressed: () {
                          print('Threshold set');
                        },
                        child: Text('Set'),
                        color: Colors.cyanAccent[700],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Set file name: '),
                      Expanded(
                        child: TextField(

                        ),
                      ),
                      //Text('meas_1 '),
                      RaisedButton(
                        onPressed: () {
                          print('Measurement name set');
                        },
                        child: Text('Set'),
                        color: Colors.cyanAccent[700],
                      ),
                    ],
                  ),
                ],
              )
          ),


          // --- Zeile 2: Icon button ------------------------------------------
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey[300],
            child: Column(
              children: <Widget>[
                Text(
                  'START MEASUREMENT',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    //color: Colors.cyanAccent[700],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('Measurement started');
                    setState(() {                   // triggers the build function to generate again
                      thresholdvalue += 1;
                      //code hier einfügen
                    });
                  },
                  icon: Icon(Icons.offline_bolt),
                  color: Colors.cyanAccent[700],
                  iconSize: 100.0,
                ),
                Text('Click to start/stop the measurement')
              ],
            ),
          ),


          // --- Zeile 3: Raised button ----------------------------------------
          /*Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey[300],

            child: RaisedButton(
              onPressed: () {
                print('Measurement started');
              },
              child: Text('Start measurement'),
              color: Colors.cyanAccent[700],
            ),
          ),*/

          // --- Zeile 4: Output -----------------------------------------------
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey[500],
              child: Column(
                  children: <Widget>[
                    Text(
                      'OUTPUT',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        //color: Colors.cyanAccent[700],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Time:'),
                          ),
                          Text('65'),
                          Text(' s'),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Average value:'),
                          ),
                          Text('50'),
                          Text(' dB'),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Max value:'),
                          ),
                          Text('90'),
                          Text(' dB'),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Min value:'),
                          ),
                          Text('40'),
                          Text(' dB'),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Actual value:'),
                          ),
                          Text('70'),
                          Text(' dB'),
                        ]
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),


    );
  }
}















// --- Backup code ----------------------------------------------------------
/*child: Image(),*/

/*CircleAvatar(
backgroundImage: AssetImage('asstes/thum.jpg'),
radius: 40.0,
),*/


/*Divider(
height: 60.0,
)*/

/*body: Center()*/

/*child: Icon(
          Icons.speaker,
          color: Colors.cyanAccent[700],
        ),'*/



/*child: Text(
          'Threshold value:',
          style: TextStyle(
            fontSize: 12.0,
            //fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[800],
          ),
        ),*/

/*SizedBox(height: 30.0),*/

/*
floatingActionButton: FloatingActionButton(
child: Text('Start Measurement'),
backgroundColor: Colors.cyanAccent[700],
),*/




/*
child: RaisedButton.icon(
onPressed: () {
print('Measurement started');
},
icon: Icon(
Icons.adjust
),
label: Text('Start measurement'),
color: Colors.cyanAccent[700],
),*/




/*
child: IconButton(
onPressed: () {
print('Measurement started');
},
icon: Icon(Icons.adjust),
color: Colors.cyanAccent[700],
iconSize: 50.0,
)*/


/*body: Container(
padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
margin: EdgeInsets.all(0),
color: Colors.grey[700],
child: Text('Hello'),
),*/


/*body: Padding(
padding: EdgeInsets.all(10),
child: Text('Hello'),
),*/


/*      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Text('Set threshold value:'),

          RaisedButton(
            onPressed: () {
              print('Threshold set');
            },
            child: Text('Set'),
            color: Colors.cyanAccent[700],
          ),
        ],
      ),*/